import 'package:dartz/dartz.dart';
import 'package:reservation_system/features/product/domain/data/datasources/product_remote_data_source_impl.dart';
import 'package:reservation_system/features/product/domain/models/product_model.dart';
import 'package:reservation_system/features/user/domain/entities/core/errors/failure.dart';
import 'package:reservation_system/features/product/domain/entities/product.dart';
import 'package:reservation_system/features/product/domain/repositories/product_repository.dart';


class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSourceImpl remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final productModels = await remoteDataSource.getAllProducts();
      final products = productModels.map((model) => model.toEntity()).toList();
      return Right(products);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(String id) async {
    try {
      final productModel = await remoteDataSource.getProductById(id);
      return Right(productModel.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Product>> createProduct(Product product) async {
    try {
      final productModel = ProductModel.fromEntity(product);
      final createdProduct = await remoteDataSource.createProduct(productModel);
      return Right(createdProduct.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct(Product product) async {
    try {
      final productModel = ProductModel.fromEntity(product);
      final updatedProduct = await remoteDataSource.updateProduct(productModel);
      return Right(updatedProduct.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    try {
      await remoteDataSource.deleteProduct(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(
      String category) async {
    try {
      final productModels =
          await remoteDataSource.getProductsByCategory(category);
      final products = productModels.map((model) => model.toEntity()).toList();
      return Right(products);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> searchProducts(String query) async {
    try {
      final productModels = await remoteDataSource.searchProducts(query);
      final products = productModels.map((model) => model.toEntity()).toList();
      return Right(products);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
