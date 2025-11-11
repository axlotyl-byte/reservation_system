import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProductById(String id);
  Future<List<ProductModel>> searchProducts(String query);
}
