import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reservation_system/features/product/presentation/providers/product_providers.dart';
import 'package:reservation_system/features/product/presentation/widgets/product_card.dart';
import 'package:reservation_system/features/product/presentation/widgets/category_filter.dart';
import 'package:reservation_system/theme/theme.dart';
import 'package:reservation_system/routes/app_routes.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productStateProvider.notifier).fetchAllProducts();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(productStateProvider);
    final isLoading = ref.watch(productsLoadingProvider);
    final error = ref.watch(productsErrorProvider);
    final categories = ref.watch(productCategoriesProvider);
    final featuredProducts = ref.watch(featuredProductsProvider);
    final searchResults = ref.watch(searchResultsProvider);

    final displayProducts = _searchController.text.isNotEmpty
        ? searchResults
        : _selectedCategory == 'All'
            ? productsState.products
            : productsState.products
                .where((p) => p.category == _selectedCategory)
                .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sweet Delights Bakery',
          style: BakeryTextStyles.appBarTitle(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // TODO: Navigate to cart
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // TODO: Profile screen navigation
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(productStateProvider.notifier).refreshProducts(),
        child: CustomScrollView(
          slivers: [
            // Search Bar
            SliverPadding(
              padding: const EdgeInsets.all(BakerySpacing.md),
              sliver: SliverToBoxAdapter(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search cakes, pastries...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              ref
                                  .read(productStateProvider.notifier)
                                  .clearSearch();
                            },
                          )
                        : null,
                    border: const OutlineInputBorder(
                      borderRadius: BakeryBorderRadius.md,
                    ),
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      ref
                          .read(productStateProvider.notifier)
                          .searchProducts(value);
                    } else {
                      ref.read(productStateProvider.notifier).clearSearch();
                    }
                  },
                ),
              ),
            ),

            // Category Filter
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: BakerySpacing.md),
              sliver: SliverToBoxAdapter(
                child: CategoryFilter(
                  categories: ['All', ...categories],
                  selectedCategory: _selectedCategory,
                  onCategorySelected: (category) {
                    setState(() {
                      _selectedCategory = category ?? 'All';
                    });
                  },
                ),
              ),
            ),

            // Featured Products
            if (_searchController.text.isEmpty && _selectedCategory == 'All')
              SliverPadding(
                padding: const EdgeInsets.all(BakerySpacing.md),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Featured Products',
                    style: BakeryTextStyles.sectionTitle(context),
                  ),
                ),
              ),
            if (_searchController.text.isEmpty && _selectedCategory == 'All')
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: BakerySpacing.md),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: BakerySpacing.md,
                    mainAxisSpacing: BakerySpacing.md,
                    childAspectRatio: 0.75,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = featuredProducts[index];
                      return ProductCard(
                        product: product,
                        onTap: () {
                          context.push(
                            AppRoute.productDetail.path
                                .replaceFirst(':id', product.id.toString()),
                          );
                        },
                      );
                    },
                    childCount: featuredProducts.length,
                  ),
                ),
              ),

            // Products Header
            SliverPadding(
              padding: const EdgeInsets.all(BakerySpacing.md),
              sliver: SliverToBoxAdapter(
                child: Text(
                  _searchController.text.isNotEmpty
                      ? 'Search Results'
                      : _selectedCategory == 'All'
                          ? 'All Products'
                          : _selectedCategory,
                  style: BakeryTextStyles.sectionTitle(context),
                ),
              ),
            ),

            // Loading
            if (isLoading && displayProducts.isEmpty)
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),

            // Error
            if (error != null && displayProducts.isEmpty)
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        'Error loading products',
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
                            .fetchAllProducts(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),

            // Empty
            if (!isLoading && error == null && displayProducts.isEmpty)
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.cake_outlined,
                          size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text(
                        _searchController.text.isNotEmpty
                            ? 'No products found'
                            : 'No products available',
                        style: BakeryTextStyles.titleMedium(context),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _searchController.text.isNotEmpty
                            ? 'Try a different search term'
                            : 'Check back later for new items',
                        style: BakeryTextStyles.bodySmall(context)
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),

            // Products Grid
            if (displayProducts.isNotEmpty)
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: BakerySpacing.md),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: BakerySpacing.md,
                    mainAxisSpacing: BakerySpacing.md,
                    childAspectRatio: 0.75,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = displayProducts[index];
                      return ProductCard(
                        product: product,
                        onTap: () {
                          context.push(
                            AppRoute.productDetail.path
                                .replaceFirst(':id', product.id.toString()),
                          );
                        },
                      );
                    },
                    childCount: displayProducts.length,
                  ),
                ),
              ),

            // Bottom Padding
            const SliverToBoxAdapter(
              child: SizedBox(height: BakerySpacing.xl),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          PrimaryScrollController.of(context).animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        backgroundColor: BakeryTheme.primaryColor,
        child: const Icon(Icons.arrow_upward, color: Colors.white),
      ),
    );
  }
}
