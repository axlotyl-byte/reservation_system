import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservation_system/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.price,
    required super.imageUrl,
    required super.description,
    required super.category,
  });

  factory ProductModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      id: doc.id,
      name: data['name'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      imageUrl: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
    );
  }

  // Add these missing methods:
  Product toEntity() {
    return Product(
      id: id,
      name: name,
      price: price,
      imageUrl: imageUrl,
      description: description,
      category: category,
    );
  }

  static ProductModel fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      name: product.name,
      price: product.price,
      imageUrl: product.imageUrl,
      description: product.description,
      category: product.category,
    );
  }

  Map<String, dynamic> toDocument() => {
        'name': name,
        'price': price,
        'imageUrl': imageUrl,
        'description': description,
        'category': category,
      };

  ProductModel copyWith({
    String? id,
    String? name,
    double? price,
    String? imageUrl,
    String? description,
    String? category,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      category: category ?? this.category,
    );
  }

  // For JSON serialization
  Map<String, dynamic> toJson() => toDocument();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProductModel &&
        other.id == id &&
        other.name == name &&
        other.price == price &&
        other.imageUrl == imageUrl &&
        other.description == description &&
        other.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        imageUrl.hashCode ^
        description.hashCode ^
        category.hashCode;
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, price: $price, imageUrl: $imageUrl, description: $description, category: $category)';
  }
}