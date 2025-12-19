import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:reservation_system/theme/theme.dart';
import 'package:reservation_system/routes/app_routes.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  String _selectedPaymentMethod = 'pay_on_pickup';
  bool _isProcessing = false;

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'id': 'pay_on_pickup',
      'title': 'Pay on Pickup',
      'description': 'Pay with cash or card when you pick up your order',
      'icon': Icons.point_of_sale,
    },
    {
      'id': 'online_payment',
      'title': 'Online Payment',
      'description': 'Pay securely with your credit/debit card',
      'icon': Icons.credit_card,
    },
    {
      'id': 'gcash',
      'title': 'GCash',
      'description': 'Pay using GCash mobile wallet',
      'icon': Icons.phone_android,
    },
  ];

  // Custom validator for GCash numbers
  String? _validateGCashNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your GCash number';
    }

    // Remove all non-digit characters (spaces, dashes, parentheses, +, etc.)
    final cleanedValue = value.replaceAll(RegExp(r'[^\d]'), '');

    // Check for valid Philippine mobile number patterns
    final validPatterns = [
      RegExp(r'^09\d{9}$'), // 09123456789 (11 digits)
      RegExp(r'^639\d{9}$'), // 639123456789 (12 digits)
    ];

    final isValid =
        validPatterns.any((pattern) => pattern.hasMatch(cleanedValue));

    if (!isValid) {
      return 'Please enter a valid GCash number (e.g., 09123456789 or +639123456789)';
    }

    // Additional check: must be exactly 11 or 12 digits after cleaning
    if (cleanedValue.length != 11 && cleanedValue.length != 12) {
      return 'GCash number must be 11 digits (09XXXXXXXXX) or 12 digits (639XXXXXXXXX)';
    }

    return null;
  }

  void _processPayment() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() {
        _isProcessing = true;
      });

      // Simulate payment processing
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isProcessing = false;
      });

      // Navigate to confirmation screen
      context.push(
        '${AppRoute.orderConfirmation.path}?orderId=ORD-${DateTime.now().millisecondsSinceEpoch}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Checkout',
          style: BakeryTextStyles.appBarTitle(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BakerySpacing.md),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Summary
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(BakerySpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Summary',
                        style: BakeryTextStyles.titleLarge(context),
                      ),
                      const SizedBox(height: BakerySpacing.md),
                      // Order items would go here
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            borderRadius: BakeryBorderRadius.sm,
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://images.unsplash.com/photo-1578986120-74d6921ce456'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: const Text('Chocolate Fudge Cake'),
                        subtitle: const Text('Quantity: 1'),
                        trailing: const Text('\$34.99'),
                      ),
                      const Divider(),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Subtotal'),
                          Text('\$34.99'),
                        ],
                      ),
                      const SizedBox(height: BakerySpacing.xs),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Tax (8%)'),
                          Text('\$2.80'),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: BakeryTextStyles.titleMedium(context),
                          ),
                          Text(
                            '\$37.79',
                            style: BakeryTextStyles.productPrice(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: BakerySpacing.lg),

              // Delivery/Pickup Information
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(BakerySpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.store, size: 20),
                          const SizedBox(width: BakerySpacing.sm),
                          Text(
                            'Store Pickup',
                            style: BakeryTextStyles.titleMedium(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: BakerySpacing.sm),
                      const Text('Sweet Delights Bakery'),
                      const Text('123 Bakery Street, City'),
                      const SizedBox(height: BakerySpacing.sm),
                      const Row(
                        children: [
                          Icon(Icons.calendar_today, size: 16),
                          SizedBox(width: BakerySpacing.xs),
                          Text('Tomorrow, 2:00 PM'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: BakerySpacing.lg),

              // Payment Method
              Text(
                'Payment Method',
                style: BakeryTextStyles.titleLarge(context),
              ),
              const SizedBox(height: BakerySpacing.md),

              ..._paymentMethods.map((method) {
                return Card(
                  margin: const EdgeInsets.only(bottom: BakerySpacing.sm),
                  child: RadioListTile(
                    title: Text(method['title']),
                    subtitle: Text(method['description']),
                    value: method['id'],
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value!;
                      });
                    },
                    secondary: Icon(method['icon']),
                  ),
                );
              }),

              const SizedBox(height: BakerySpacing.lg),

              // Payment Details (conditional)
              if (_selectedPaymentMethod == 'online_payment')
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(BakerySpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Card Details',
                          style: BakeryTextStyles.titleMedium(context),
                        ),
                        const SizedBox(height: BakerySpacing.md),
                        FormBuilderTextField(
                          name: 'card_number',
                          decoration: const InputDecoration(
                            labelText: 'Card Number',
                            border: OutlineInputBorder(
                              borderRadius: BakeryBorderRadius.md,
                            ),
                            prefixIcon: Icon(Icons.credit_card),
                          ),
                          keyboardType: TextInputType.number,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.creditCard(),
                          ]),
                        ),
                        const SizedBox(height: BakerySpacing.md),
                        Row(
                          children: [
                            Expanded(
                              child: FormBuilderTextField(
                                name: 'expiry_date',
                                decoration: const InputDecoration(
                                  labelText: 'MM/YY',
                                  border: OutlineInputBorder(
                                    borderRadius: BakeryBorderRadius.md,
                                  ),
                                ),
                                validator: FormBuilderValidators.required(),
                              ),
                            ),
                            const SizedBox(width: BakerySpacing.md),
                            Expanded(
                              child: FormBuilderTextField(
                                name: 'cvv',
                                decoration: const InputDecoration(
                                  labelText: 'CVV',
                                  border: OutlineInputBorder(
                                    borderRadius: BakeryBorderRadius.md,
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.numeric(),
                                  FormBuilderValidators.minLength(3),
                                  FormBuilderValidators.maxLength(4),
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

              if (_selectedPaymentMethod == 'gcash')
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(BakerySpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'GCash Payment',
                          style: BakeryTextStyles.titleMedium(context),
                        ),
                        const SizedBox(height: BakerySpacing.md),
                        FormBuilderTextField(
                          name: 'gcash_number',
                          decoration: const InputDecoration(
                            labelText: 'GCash Mobile Number',
                            hintText: '09123456789 or +639123456789',
                            border: OutlineInputBorder(
                              borderRadius: BakeryBorderRadius.md,
                            ),
                            prefixIcon: Icon(Icons.phone),
                            prefixText: '+63 ',
                          ),
                          keyboardType: TextInputType.phone,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            (value) => _validateGCashNumber(value),
                          ]),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[\d\+]')), // Allow digits and +
                            LengthLimitingTextInputFormatter(
                                13), // Max length for +639123456789
                          ],
                        ),
                        const SizedBox(height: BakerySpacing.md),
                        const Text(
                          'You will receive a payment request via GCash.',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: BakerySpacing.xl),

              // Terms and Conditions
              FormBuilderCheckbox(
                name: 'agree_terms',
                title: const Text(
                  'I agree to the Terms and Conditions',
                  style: TextStyle(fontSize: 14),
                ),
                validator: FormBuilderValidators.equal(
                  true,
                  errorText: 'Please agree to the terms and conditions',
                ),
              ),

              const SizedBox(height: BakerySpacing.xl),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(BakerySpacing.md),
          child: _isProcessing
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: _processPayment,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Confirm Order & Pay'),
                ),
        ),
      ),
    );
  }
}
