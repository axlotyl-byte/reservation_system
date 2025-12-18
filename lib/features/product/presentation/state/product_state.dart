import 'package:reservation_system/features/product/domain/entities/product.dart';

/// State class representing the product management state
class ProductState {
  final List<Product> products;
  final List<Product> searchResults;
  final Product? currentProduct;
  final bool isLoading;
  final String? error;
  final bool success;
  final String? selectedCategory;
  final String? searchQuery;

  const ProductState({
    this.products = const [],
    this.searchResults = const [],
    this.currentProduct,
    this.isLoading = false,
    this.error,
    this.success = false,
    this.selectedCategory,
    this.searchQuery,
  });

  /// Copy with method for immutable state updates
  ProductState copyWith({
    List<Product>? products,
    List<Product>? searchResults,
    Product? currentProduct,
    bool? isLoading,
    String? error,
    bool? success,
    String? selectedCategory,
    String? searchQuery,
  }) {
    return ProductState(
      products: products ?? this.products,
      searchResults: searchResults ?? this.searchResults,
      currentProduct: currentProduct ?? this.currentProduct,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      success: success ?? this.success,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductState &&
        other.products == products &&
        other.searchResults == searchResults &&
        other.currentProduct == currentProduct &&
        other.isLoading == isLoading &&
        other.error == error &&
        other.success == success &&
        other.selectedCategory == selectedCategory &&
        other.searchQuery == searchQuery;
  }

  @override
  int get hashCode {
    return products.hashCode ^
        searchResults.hashCode ^
        currentProduct.hashCode ^
        isLoading.hashCode ^
        error.hashCode ^
        success.hashCode ^
        selectedCategory.hashCode ^
        searchQuery.hashCode;
  }

  @override
  String toString() {
    return 'ProductState(products: ${products.length}, searchResults: ${searchResults.length}, '
        'currentProduct: ${currentProduct?.id}, isLoading: $isLoading, error: $error, '
        'success: $success, selectedCategory: $selectedCategory, searchQuery: $searchQuery)';
  }
}
