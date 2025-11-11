import 'package:dartz/dartz.dart';
import '../entities/product.dart';
import 'package:reservation_system/features/user/domain/entities/core/errors/failure.dart';
import '../repositories/product_repository.dart';

class GetProductById {
  final ProductRepository repository;
  GetProductById(this.repository);

  Future<Either<Failure, Product>> call(String id) {
    return repository.getProductById(id);
  }
}
