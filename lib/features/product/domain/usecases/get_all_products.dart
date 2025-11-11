import 'package:dartz/dartz.dart';
import '../entities/product.dart';
import 'package:reservation_system/features/user/domain/entities/core/errors/failure.dart';
import '../repositories/product_repository.dart';

class GetAllProducts {
  final ProductRepository repository;
  GetAllProducts(this.repository);

  Future<Either<Failure, List<Product>>> call() {
    return repository.getAllProducts();
  }
}
