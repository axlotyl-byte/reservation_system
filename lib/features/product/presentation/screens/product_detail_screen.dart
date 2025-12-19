import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reservation_system/features/product/presentation/providers/product_providers.dart';
import 'package:reservation_system/theme/theme.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final String productId; // Required

  const ProductDetailScreen({super.key, required this.productId});

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  int _quantity = 1;

  @override
  void initState() {
    super.initState();

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
        appBar: AppBar(leading: const BackButton()),
        body: Center(child: Text(error)),
      );
    }

    if (product == null) {
      return const Scaffold(
        body: Center(child: Text('Product not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(product.name, style: BakeryTextStyles.titleLarge(context)),
            const SizedBox(height: 8),
            Text(product.description,
                style: BakeryTextStyles.bodyMedium(context)),
            const SizedBox(height: 16),
            // Quantity selector
            Row(
              children: [
                const Text('Quantity:'),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed:
                      _quantity > 1 ? () => setState(() => _quantity--) : null,
                ),
                Text(_quantity.toString()),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => setState(() => _quantity++),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.push('/pre-order/${product.id}');
              },
              child: const Text('Pre-Order Now'),
            ),
          ],
        ),
      ),
    );
  }
}
