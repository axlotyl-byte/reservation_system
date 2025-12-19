import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reservation_system/features/product/presentation/providers/product_providers.dart';
import 'package:reservation_system/theme/theme.dart';
import 'package:reservation_system/routes/app_routes.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  int _quantity = 1;
  String? _selectedSize;
  String? _selectedFlavor;

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

  @override
  Widget build(BuildContext context) {
    final product = ref.watch(currentProductProvider);
    final isLoading = ref.watch(productsLoadingProvider);
    final error = ref.watch(productsErrorProvider);

    if (isLoading && product == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null && product == null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Error loading product',
                style: BakeryTextStyles.titleMedium(context),
              ),
              const SizedBox(height: 8),
              Text(
                error,
                textAlign: TextAlign.center,
                style: BakeryTextStyles.bodySmall(context),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref
                    .read(productStateProvider.notifier)
                    .fetchProductById(widget.productId),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(
          product.name,
          style: BakeryTextStyles.appBarTitle(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // todo: Share product
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // todo: Add to favorites
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(product.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(BakerySpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name and Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: BakeryTextStyles.headlineSmall(context),
                        ),
                      ),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: BakeryTextStyles.productPrice(context),
                      ),
                    ],
                  ),

                  const SizedBox(height: BakerySpacing.sm),

                  // Category Chip
                  Chip(
                    label: Text(product.category),
                    backgroundColor: BakeryTheme.primaryColor.withOpacity(0.1),
                  ),

                  const SizedBox(height: BakerySpacing.md),

                  // Description
                  Text(
                    'Description',
                    style: BakeryTextStyles.titleMedium(context),
                  ),
                  const SizedBox(height: BakerySpacing.xs),
                  Text(
                    product.description,
                    style: BakeryTextStyles.bodyMedium(context),
                  ),

                  const SizedBox(height: BakerySpacing.lg),

                  // Size Selection (if applicable)
                  if (product.category == 'Cakes')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Size',
                          style: BakeryTextStyles.titleSmall(context),
                        ),
                        const SizedBox(height: BakerySpacing.sm),
                        Wrap(
                          spacing: BakerySpacing.sm,
                          children: ['Small', 'Medium', 'Large'].map((size) {
                            return ChoiceChip(
                              label: Text(size),
                              selected: _selectedSize == size,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedSize = selected ? size : null;
                                });
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: BakerySpacing.md),
                      ],
                    ),

                  // Flavor Selection (if applicable)
                  if (product.category == 'Cakes')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Flavor',
                          style: BakeryTextStyles.titleSmall(context),
                        ),
                        const SizedBox(height: BakerySpacing.sm),
                        Wrap(
                          spacing: BakerySpacing.sm,
                          children: [
                            'Chocolate',
                            'Vanilla',
                            'Red Velvet',
                            'Carrot'
                          ].map((flavor) {
                            return ChoiceChip(
                              label: Text(flavor),
                              selected: _selectedFlavor == flavor,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedFlavor = selected ? flavor : null;
                                });
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: BakerySpacing.md),
                      ],
                    ),

                  // Quantity Selector
                  Row(
                    children: [
                      Text(
                        'Quantity',
                        style: BakeryTextStyles.titleSmall(context),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BakeryBorderRadius.md,
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: _quantity > 1
                                  ? () {
                                      setState(() {
                                        _quantity--;
                                      });
                                    }
                                  : null,
                            ),
                            SizedBox(
                              width: 40,
                              child: Center(
                                child: Text(
                                  '$_quantity',
                                  style: BakeryTextStyles.titleMedium(context),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
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

                  const SizedBox(height: BakerySpacing.xl),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(BakerySpacing.md),
          child: Row(
            children: [
              // Add to Cart Button
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // todo: Add to cart
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Added ${product.name} to cart'),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Add to Cart'),
                ),
              ),
              const SizedBox(width: BakerySpacing.md),
              // Pre-Order Button
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.push(
                      AppRoute.preOrder.path.replaceFirst(
                        ':id',
                        product.id,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Pre-Order Now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
