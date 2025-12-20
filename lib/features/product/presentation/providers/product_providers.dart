import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservation_system/features/product/domain/data/datasources/product_remote_data_source_impl.dart';
import 'package:reservation_system/features/product/domain/models/product_model.dart';
import 'package:reservation_system/features/product/domain/entities/product.dart';
import 'package:reservation_system/features/product/domain/repositories/product_repository.dart';
import 'package:reservation_system/features/product/repositories/product_repository_impl.dart';
import 'package:reservation_system/features/product/domain/usecases/get_all_products.dart';
import 'package:reservation_system/features/product/domain/usecases/get_products_by_id.dart';
import 'package:reservation_system/features/product/domain/usecases/search_products.dart';
import 'package:reservation_system/features/product/presentation/state/product_state.dart';
import 'package:reservation_system/features/product/presentation/providers/controllers/product_controller.dart';

// ==================== DATASOURCE PROVIDERS ====================

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final productRemoteDataSourceProvider =
    Provider<ProductRemoteDataSourceImpl>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return ProductRemoteDataSourceImpl(firestore);
});

// ==================== REPOSITORY PROVIDERS ====================

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final remoteDataSource = ref.watch(productRemoteDataSourceProvider);
  return ProductRepositoryImpl(remoteDataSource: remoteDataSource);
});

// ==================== USECASE PROVIDERS ====================

final getAllProductsUsecaseProvider = Provider<GetAllProducts>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return GetAllProducts(repository);
});

final getProductByIdUsecaseProvider = Provider<GetProductById>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return GetProductById(repository);
});

final searchProductsUsecaseProvider = Provider<SearchProducts>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return SearchProducts(repository);
});

// ==================== STATE PROVIDER ====================

final productStateProvider =
    StateNotifierProvider<ProductController, ProductState>((ref) {
  return ProductController(
    getAllProducts: ref.watch(getAllProductsUsecaseProvider),
    getProductById: ref.watch(getProductByIdUsecaseProvider),
    searchProducts: ref.watch(searchProductsUsecaseProvider),
  );
});

// ==================== SELECTOR PROVIDERS ====================

final allProductsProvider = Provider<List<Product>>((ref) {
  return ref.watch(productStateProvider).products;
});

final currentProductProvider = Provider<Product?>((ref) {
  return ref.watch(productStateProvider).currentProduct;
});

final searchResultsProvider = Provider<List<Product>>((ref) {
  return ref.watch(productStateProvider).searchResults;
});

final productsLoadingProvider = Provider<bool>((ref) {
  return ref.watch(productStateProvider).isLoading;
});

final productsErrorProvider = Provider<String?>((ref) {
  return ref.watch(productStateProvider).error;
});

final operationSuccessProvider = Provider<bool>((ref) {
  return ref.watch(productStateProvider).success;
});

// ==================== CATEGORY & FILTER PROVIDERS ====================

final productsByCategoryProvider =
    Provider.family<List<Product>, String>((ref, category) {
  final products = ref.watch(allProductsProvider);
  return products.where((product) => product.category == category).toList();
});

final productCategoriesProvider = Provider<List<String>>((ref) {
  final products = ref.watch(allProductsProvider);
  final categories =
      products.map((product) => product.category).toSet().toList();
  categories.sort();
  return categories;
});

final featuredProductsProvider = Provider<List<Product>>((ref) {
  final products = ref.watch(allProductsProvider);
  return products.take(6).toList();
});

final productsByPriceRangeProvider =
    Provider.family<List<Product>, ({double min, double max})>((ref, range) {
  final products = ref.watch(allProductsProvider);
  return products
      .where((p) => p.price >= range.min && p.price <= range.max)
      .toList();
});

final searchQueryProvider =
    Provider.family<List<Product>, String>((ref, query) {
  final products = ref.watch(allProductsProvider);
  if (query.isEmpty) return [];

  final q = query.toLowerCase();
  return products.where((product) {
    return product.name.toLowerCase().contains(q) ||
        product.description.toLowerCase().contains(q) ||
        product.category.toLowerCase().contains(q);
  }).toList();
});

// ==================== STREAM PROVIDER (REALTIME) ====================

final productsStreamProvider = StreamProvider<List<Product>>((ref) {
  final firestore = ref.watch(firestoreProvider);

  return firestore.collection('products').snapshots().map((snapshot) {
    return snapshot.docs
        .map((doc) => ProductModel.fromSnapshot(doc).toEntity())
        .toList();
  });
});

// ==================== FAMILY PROVIDERS ====================

final productByIdProvider = Provider.family<Product?, String>((ref, id) {
  final products = ref.watch(allProductsProvider);
  try {
    return products.firstWhere((product) => product.id == id);
  } catch (_) {
    return null;
  }
});
