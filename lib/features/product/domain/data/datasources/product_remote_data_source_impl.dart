import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/product_model.dart';
import 'product_remote_data_source.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final FirebaseFirestore firestore;
  ProductRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final snapshot = await firestore.collection('products').get();
    return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    final doc = await firestore.collection('products').doc(id).get();
    if (!doc.exists) {
      throw Exception('Product not found');
    }
    return ProductModel.fromSnapshot(doc);
  }

  @override
  Future<ProductModel> createProduct(ProductModel product) async {
    final docRef = firestore.collection('products').doc();
    final productWithId = product.copyWith(id: docRef.id);

    await docRef.set(productWithId.toDocument());
    return productWithId;
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    await firestore.collection('products').doc(product.id).update(
          product.toDocument(),
        );
    return product;
  }

  @override
  Future<void> deleteProduct(String id) async {
    await firestore.collection('products').doc(id).delete();
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    final snapshot = await firestore
        .collection('products')
        .where('category', isEqualTo: category)
        .get();
    return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    final snapshot = await firestore
        .collection('products')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: query + '\uf8ff')
        .get();
    return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
  }
}
