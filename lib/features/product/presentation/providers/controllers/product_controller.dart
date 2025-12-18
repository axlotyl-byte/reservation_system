import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservation_system/features/product/domain/entities/product.dart';
import 'package:reservation_system/features/product/domain/usecases/get_all_products.dart';
import 'package:reservation_system/features/product/domain/usecases/get_products_by_id.dart';
import 'package:reservation_system/features/product/domain/usecases/search_products.dart';
import 'package:reservation_system/features/product/presentation/state/product_state.dart';

/// Controller class for managing product state and operations
class ProductController extends StateNotifier<ProductState> {
  final GetAllProducts _getAllProducts;
  final GetProductById _getProductById;
  final SearchProducts _searchProducts;

  ProductController({
    required GetAllProducts getAllProducts,
    required GetProductById getProductById,
    required SearchProducts searchProducts,
  })  : _getAllProducts = getAllProducts,
        _getProductById = getProductById,
        _searchProducts = searchProducts,
        super(const ProductState());

  // ==================== GET OPERATIONS ====================

  /// Fetch all products
  Future<void> fetchAllProducts() async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final result = await _getAllProducts();

      result.fold(
        (failure) {
          state = state.copyWith(
            isLoading: false,
            error: failure.message,
            success: false,
          );
        },
        (products) {
          state = state.copyWith(
            products: products,
            isLoading: false,
            error: null,
            success: true,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        success: false,
      );
    }
  }

  /// Fetch a single product by ID
  Future<void> fetchProductById(String id) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final result = await _getProductById(id);

      result.fold(
        (failure) {
          state = state.copyWith(
            isLoading: false,
            error: failure.message,
            success: false,
          );
        },
        (product) {
          state = state.copyWith(
            currentProduct: product,
            isLoading: false,
            error: null,
            success: true,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        success: false,
      );
    }
  }

  // ==================== SEARCH OPERATIONS ====================

  /// Search products by query
  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      state = state.copyWith(
        searchResults: [],
        searchQuery: query,
      );
      return;
    }

    try {
      state = state.copyWith(
        isLoading: true,
        error: null,
        searchQuery: query,
      );

      final result = await _searchProducts(query);

      result.fold(
        (failure) {
          state = state.copyWith(
            isLoading: false,
            error: failure.message,
            success: false,
          );
        },
        (products) {
          state = state.copyWith(
            searchResults: products,
            isLoading: false,
            error: null,
            success: true,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        success: false,
      );
    }
  }

  /// Clear search results
  void clearSearch() {
    state = state.copyWith(
      searchResults: [],
      searchQuery: null,
    );
  }

  // ==================== STATE HELPERS ====================

  /// Clear current product
  void clearCurrentProduct() {
    state = state.copyWith(currentProduct: null);
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Reset success flag
  void resetSuccess() {
    state = state.copyWith(success: false);
  }

  /// Select a category
  void selectCategory(String category) {
    state = state.copyWith(selectedCategory: category);
  }

  /// Clear selected category
  void clearSelectedCategory() {
    state = state.copyWith(selectedCategory: null);
  }

  /// Refresh products
  Future<void> refreshProducts() async {
    await fetchAllProducts();
  }

  /// Set products manually
  void setProducts(List<Product> products) {
    state = state.copyWith(products: products);
  }

  // ==================== FILTER METHODS ====================

  /// Filter products by category
  List<Product> getProductsByCategory(String category) {
    return state.products
        .where((product) => product.category == category)
        .toList();
  }

  /// Get featured products (first N products)
  List<Product> getFeaturedProducts({int limit = 6}) {
    return state.products.take(limit).toList();
  }
}
