import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';
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
    return ProductModel.fromSnapshot(doc);
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    final snapshot = await firestore
        .collection('products')
        .where('name', isGreaterThanOrEqualTo: query)
        .get();
    return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
  }
}
