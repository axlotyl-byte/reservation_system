import 'package:dartz/dartz.dart';
import '../entities/product.dart';
import 'package:reservation_system/features/user/domain/entities/core/errors/failure.dart';
import '../repositories/product_repository.dart';

class SearchProducts {
  final ProductRepository repository;
  SearchProducts(this.repository);

  Future<Either<Failure, List<Product>>> call(String query) {
    return repository.searchProducts(query);
  }
}
