import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservation_system/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.price,
    required super.imageUrl,
    required super.description,
  });

  factory ProductModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      id: doc.id,
      name: data['name'],
      price: (data['price'] ?? 0).toDouble(),
      imageUrl: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'imageUrl': imageUrl,
        'description': description,
      };
}
