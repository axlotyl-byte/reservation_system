import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:reservation_system/features/product/presentation/providers/product_providers.dart';
import 'package:reservation_system/theme/theme.dart';
import 'package:reservation_system/routes/app_routes.dart';

class PreOrderScreen extends ConsumerStatefulWidget {
  final String productId;

  const PreOrderScreen({super.key, required this.productId});

  @override
  ConsumerState<PreOrderScreen> createState() => _PreOrderScreenState();
}

class _PreOrderScreenState extends ConsumerState<PreOrderScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  int _quantity = 1;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    // Fetch product details
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(productStateProvider.notifier)
          .fetchProductById(widget.productId);
    });
  }

  // Custom phone number validator for Philippine numbers
  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }

    // Remove all non-digit characters
    final cleanedValue = value.replaceAll(RegExp(r'[^\d]'), '');

    // Must be exactly 11 or 12 digits
    if (cleanedValue.length != 11 && cleanedValue.length != 12) {
      return 'Phone number must be 11 or 12 digits';
    }

    // Must start with valid Philippine mobile prefixes
    if (!cleanedValue.startsWith('09') && !cleanedValue.startsWith('639')) {
      return 'Must start with 09 or 639';
    }

    // If starts with 09, must be exactly 11 digits
    if (cleanedValue.startsWith('09') && cleanedValue.length != 11) {
      return '09 numbers must be 11 digits (e.g., 09123456789)';
    }

    // If starts with 639, must be exactly 12 digits
    if (cleanedValue.startsWith('639') && cleanedValue.length != 12) {
      return '639 numbers must be 12 digits (e.g., 639123456789)';
    }

    return null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final firstDate = now.add(const Duration(days: 1));
    final lastDate = now.add(const Duration(days: 30));

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: firstDate,
      firstDate: firstDate,
      lastDate: lastDate,
      selectableDayPredicate: (DateTime day) {
        // Disable Sundays
        return day.weekday != DateTime.sunday;
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 0),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: BakeryTheme.primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      // Get product from provider directly
      final product = ref.read(currentProductProvider);

      if (product == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Product information not available'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final totalPrice = product.price * _quantity;
      final formData = Map<String, dynamic>.from(_formKey.currentState!.value);

      // Add additional data not in form fields
      formData['quantity'] = _quantity;
      formData['product_id'] = widget.productId;
      formData['product_name'] = product.name;
      formData['unit_price'] = product.price;
      formData['total_price'] = totalPrice;
      formData['tax'] = totalPrice * 0.08;
      formData['grand_total'] = totalPrice * 1.08;

      // Format date and time for display/backend
      if (_selectedDate != null) {
        formData['pickup_date_formatted'] =
            DateFormat('yyyy-MM-dd').format(_selectedDate!);
        formData['pickup_date_readable'] =
            DateFormat('EEEE, MMMM d, yyyy').format(_selectedDate!);
      }

      if (_selectedTime != null) {
        formData['pickup_time_formatted'] =
            '${_selectedTime!.hour}:${_selectedTime!.minute.toString().padLeft(2, '0')}';
      }

      // Debug: Print form data
      print('=== Pre-Order Form Data ===');
      formData.forEach((key, value) {
        print('$key: $value');
      });
      print('==========================');

      context.push(
        '${AppRoute.checkout.path}?productId=${widget.productId}',
        extra: formData,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields correctly'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = ref.watch(currentProductProvider);
    final isLoading = ref.watch(productsLoadingProvider);

    if (isLoading && product == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (product == null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: const Center(
          child: Text('Product not found'),
        ),
      );
    }

    final totalPrice = product.price * _quantity;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Pre-Order: ${product.name}',
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
              // Quantity hidden field
              FormBuilderField<int>(
                name: 'quantity',
                initialValue: _quantity,
                builder: (field) => const SizedBox.shrink(),
              ),

              // Product Summary Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(BakerySpacing.md),
                  child: Row(
                    children: [
                      // Product Image
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BakeryBorderRadius.sm,
                          image: DecorationImage(
                            image: NetworkImage(product.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: BakerySpacing.md),
                      // Product Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: BakeryTextStyles.titleMedium(context),
                            ),
                            const SizedBox(height: BakerySpacing.xs),
                            Text(
                              product.category,
                              style:
                                  BakeryTextStyles.bodySmall(context).copyWith(
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: BakerySpacing.sm),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$${product.price.toStringAsFixed(2)} each',
                                  style: BakeryTextStyles.bodyMedium(context),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                    borderRadius: BakeryBorderRadius.sm,
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon:
                                            const Icon(Icons.remove, size: 18),
                                        onPressed: _quantity > 1
                                            ? () {
                                                setState(() {
                                                  _quantity--;
                                                });
                                              }
                                            : null,
                                      ),
                                      SizedBox(
                                        width: 30,
                                        child: Center(
                                          child: Text(
                                            '$_quantity',
                                            style: BakeryTextStyles.bodyMedium(
                                                context),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add, size: 18),
                                        onPressed: () {
                                          setState(() {
                                            _quantity++;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: BakerySpacing.lg),

              // Pickup Date & Time
              Text(
                'Pickup Details',
                style: BakeryTextStyles.titleLarge(context),
              ),
              const SizedBox(height: BakerySpacing.md),

              // Date Picker
              FormBuilderField<DateTime>(
                name: 'pickup_date',
                initialValue: _selectedDate,
                validator: FormBuilderValidators.required(),
                builder: (field) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Pickup Date',
                          border: const OutlineInputBorder(
                            borderRadius: BakeryBorderRadius.md,
                          ),
                          errorText: field.errorText,
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.calendar_today),
                          title: Text(
                            _selectedDate != null
                                ? DateFormat('EEEE, MMMM d, yyyy')
                                    .format(_selectedDate!)
                                : 'Select a date',
                          ),
                          trailing: const Icon(Icons.arrow_drop_down),
                          onTap: () async {
                            await _selectDate(context);
                            field.didChange(_selectedDate);
                          },
                        ),
                      ),
                      if (field.errorText != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 12.0),
                          child: Text(
                            field.errorText!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),

              const SizedBox(height: BakerySpacing.md),

              // Time Picker
              FormBuilderField<TimeOfDay>(
                name: 'pickup_time',
                initialValue: _selectedTime,
                validator: FormBuilderValidators.required(),
                builder: (field) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Pickup Time',
                          border: const OutlineInputBorder(
                            borderRadius: BakeryBorderRadius.md,
                          ),
                          errorText: field.errorText,
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.access_time),
                          title: Text(
                            _selectedTime != null
                                ? _selectedTime!.format(context)
                                : 'Select a time',
                          ),
                          trailing: const Icon(Icons.arrow_drop_down),
                          onTap: () async {
                            await _selectTime(context);
                            field.didChange(_selectedTime);
                          },
                        ),
                      ),
                      if (field.errorText != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 12.0),
                          child: Text(
                            field.errorText!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),

              const SizedBox(height: BakerySpacing.md),

              // Special Instructions
              FormBuilderTextField(
                name: 'special_instructions',
                decoration: const InputDecoration(
                  labelText: 'Special Instructions (Optional)',
                  hintText: 'e.g., "Happy Birthday Anna", "No nuts", etc.',
                  border: OutlineInputBorder(
                    borderRadius: BakeryBorderRadius.md,
                  ),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                minLines: 2,
              ),

              const SizedBox(height: BakerySpacing.lg),

              // Contact Information
              Text(
                'Contact Information',
                style: BakeryTextStyles.titleLarge(context),
              ),
              const SizedBox(height: BakerySpacing.md),

              FormBuilderTextField(
                name: 'customer_name',
                decoration: const InputDecoration(
                  labelText: 'Your Name',
                  border: OutlineInputBorder(
                    borderRadius: BakeryBorderRadius.md,
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: FormBuilderValidators.required(
                  errorText: 'Please enter your name',
                ),
              ),

              const SizedBox(height: BakerySpacing.md),

              FormBuilderTextField(
                name: 'customer_phone',
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: '09123456789 or +639123456789',
                  border: OutlineInputBorder(
                    borderRadius: BakeryBorderRadius.md,
                  ),
                  prefixIcon: Icon(Icons.phone),
                  prefixText: '+63 ',
                ),
                keyboardType: TextInputType.phone,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'Please enter your phone number',
                  ),
                  (value) => _validatePhoneNumber(value), // Custom validator
                ]),
              ),

              const SizedBox(height: BakerySpacing.md),

              FormBuilderTextField(
                name: 'customer_email',
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(
                    borderRadius: BakeryBorderRadius.md,
                  ),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'Please enter your email',
                  ),
                  FormBuilderValidators.email(
                    errorText: 'Please enter a valid email',
                  ),
                ]),
              ),

              const SizedBox(height: BakerySpacing.xl),

              // Order Summary
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(BakerySpacing.md),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal',
                            style: BakeryTextStyles.bodyMedium(context),
                          ),
                          Text(
                            '\$${totalPrice.toStringAsFixed(2)}',
                            style: BakeryTextStyles.bodyMedium(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: BakerySpacing.sm),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tax',
                            style: BakeryTextStyles.bodyMedium(context),
                          ),
                          Text(
                            '\$${(totalPrice * 0.08).toStringAsFixed(2)}',
                            style: BakeryTextStyles.bodyMedium(context),
                          ),
                        ],
                      ),
                      const Divider(height: BakerySpacing.lg),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: BakeryTextStyles.titleMedium(context),
                          ),
                          Text(
                            '\$${(totalPrice * 1.08).toStringAsFixed(2)}',
                            style: BakeryTextStyles.productPrice(context),
                          ),
                        ],
                      ),
                    ],
                  ),
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
          child: ElevatedButton(
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Proceed to Checkout'),
          ),
        ),
      ),
    );
  }
}
