import 'package:dartz/dartz.dart';
import 'package:reservation_system/features/user/domain/entities/core/errors/failure.dart';
import 'package:reservation_system/features/product/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, Product>> getProductById(String id);
  Future<Either<Failure, List<Product>>> searchProducts(String query);
  Future<Either<Failure, Product>> createProduct(Product product);
  Future<Either<Failure, Product>> updateProduct(Product product);
  Future<Either<Failure, void>> deleteProduct(String id);
  Future<Either<Failure, List<Product>>> getProductsByCategory(String category);
}
