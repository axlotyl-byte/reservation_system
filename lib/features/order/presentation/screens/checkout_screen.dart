import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reservation_system/features/order/presentation/providers/order_providers.dart';
import 'package:reservation_system/features/order/domain/entities/order.dart';
import 'package:reservation_system/features/order/domain/entities/order_item.dart';
import 'package:reservation_system/features/cart/presentation/cart_provider.dart';
import 'package:reservation_system/features/cart/domain/models/cart_item.dart';
import 'package:reservation_system/theme/theme.dart';
import 'package:reservation_system/theme/widgets.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _noteController = TextEditingController();
  String _paymentMethod = 'cash';
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  final List<Map<String, dynamic>> _paymentMethods = [
    {'id': 'cash', 'name': 'Cash on Pickup', 'icon': Icons.money},
    {'id': 'card', 'name': 'Credit/Debit Card', 'icon': Icons.credit_card},
    {'id': 'paypal', 'name': 'PayPal', 'icon': Icons.payment},
  ];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  void _placeOrder() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null || _selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select pickup date and time')),
        );
        return;
      }

      final pickupDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      final cart = ref.read(cartProvider);
      final order = Order(
        id: 'ORD${DateTime.now().millisecondsSinceEpoch}',
        customerId: 'current_user_id',
        items: cart.items
            .map(
              (item) => OrderItem(
                productId: item.productId,
                productName: item.productName,
                quantity: item.quantity,
                price: item.price,
              ),
            )
            .toList(),
        totalAmount: cart.totalAmount,
        status: 'pending',
        createdAt: DateTime.now(),
        pickupDate: pickupDateTime,
      );

      ref.read(orderNotifierProvider.notifier).createOrder(order);
      context.go('/order-confirmation?orderId=${order.id}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final isLoading = ref.watch(ordersLoadingProvider);

    if (cart.items.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Checkout')),
        body: context.emptyState(
          icon: Icons.shopping_cart_outlined,
          title: 'Your cart is empty',
          description: 'Add delicious bakery items to get started!',
          action: ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text('Browse Products'),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Order Summary
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order Summary',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 12),
                    ...cart.items
                        .map((item) =>
                            _buildCartItem(item, cartNotifier, context))
                        .toList(),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total', style: TextStyle(fontSize: 16)),
                        context.priceDisplay(
                          price: cart.totalAmount,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: BakeryTheme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Pickup Date & Time
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pickup Details',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _selectDate,
                            icon: const Icon(Icons.calendar_today),
                            label: Text(
                              _selectedDate == null
                                  ? 'Select Date'
                                  : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _selectTime,
                            icon: const Icon(Icons.access_time),
                            label: Text(
                              _selectedTime == null
                                  ? 'Select Time'
                                  : '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Payment Method
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Payment Method',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 12),
                    ..._paymentMethods
                        .map((method) => _buildPaymentMethod(method))
                        .toList(),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Special Instructions
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Special Instructions',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _noteController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Add any special requests or notes...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey[300]!)),
        ),
        child: ElevatedButton(
          onPressed: isLoading ? null : _placeOrder,
          style: ElevatedButton.styleFrom(
            backgroundColor: BakeryTheme.primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text('Place Order'),
        ),
      ),
    );
  }

  Widget _buildCartItem(
      CartItem item, CartNotifier cartNotifier, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.cake, color: Colors.grey),
          ),
          const SizedBox(width: 12),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.productName,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                context.quantitySelector(
                  quantity: item.quantity,
                  onDecrease: () => cartNotifier.updateQuantity(
                      item.productId, item.quantity - 1),
                  onIncrease: () => cartNotifier.updateQuantity(
                      item.productId, item.quantity + 1),
                ),
              ],
            ),
          ),

          // Price display
          context.priceDisplay(price: item.price * item.quantity),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod(Map<String, dynamic> method) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: _paymentMethod == method['id']
          ? BakeryTheme.primaryColor.withOpacity(0.1)
          : null,
      child: RadioListTile(
        title: Row(
          children: [
            Icon(method['icon'] as IconData, color: BakeryTheme.primaryColor),
            const SizedBox(width: 12),
            Text(method['name']),
          ],
        ),
        value: method['id'],
        groupValue: _paymentMethod,
        onChanged: (value) => setState(() => _paymentMethod = value.toString()),
      ),
    );
  }
}
