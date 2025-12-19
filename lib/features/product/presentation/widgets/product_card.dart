import 'package:flutter/material.dart';
import 'package:reservation_system/features/product/domain/entities/product.dart';
import 'package:reservation_system/theme/theme.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final bool showCategory;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    this.showCategory = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BakeryBorderRadius.md,
      ),
      child: InkWell(
        onTap: onTap, // Removed isAvailable check
        borderRadius: BakeryBorderRadius.md,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: Icon(
                              Icons.cake,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // REMOVED: Availability Badge (used isAvailable)
                  // REMOVED: Reservable Badge (used isReservable)
                ],
              ),
            ),

            // Product Info
            Padding(
              padding: const EdgeInsets.all(BakerySpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category
                  if (showCategory)
                    Padding(
                      padding: const EdgeInsets.only(bottom: BakerySpacing.xs),
                      child: Text(
                        product.category.toUpperCase(),
                        style: BakeryTextStyles.bodySmall(context).copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                  // Product Name
                  Text(
                    product.name,
                    style: BakeryTextStyles.productName(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: BakerySpacing.xs),

                  // Description
                  Text(
                    product.description,
                    style: BakeryTextStyles.productDescription(context),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: BakerySpacing.md),

                  // Price and Action Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: BakeryTextStyles.productPrice(context),
                      ),
                      // REMOVED: isAvailable check for add button
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: BakerySpacing.sm,
                          vertical: BakerySpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: BakeryTheme.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 16,
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
    );
  }
}
