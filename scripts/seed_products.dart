import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservation_system/features/product/domain/data/datasources/product_remote_data_source_impl.dart';
import 'package:reservation_system/features/product/domain/models/product_model.dart';

Future<void> seedProducts() async {
  final firestore = FirebaseFirestore.instance;
  final productDataSource = ProductRemoteDataSourceImpl(firestore);

  // Bakery products - ONLY using the 6 fields that ProductModel requires
  final bakeryProducts = [
    const ProductModel(
      id: '', // Required field
      name: 'Sourdough Loaf',
      price: 7.99, // double
      imageUrl: 'https://example.com/sourdough.jpg',
      description: 'Artisan sourdough with crispy crust and soft interior',
      category: 'Bread',
    ),
    const ProductModel(
      id: '',
      name: 'Whole Wheat Bread',
      price: 6.50,
      imageUrl: 'https://example.com/wholewheat.jpg',
      description: 'Healthy whole wheat bread with nuts and seeds',
      category: 'Bread',
    ),
    const ProductModel(
      id: '',
      name: 'Baguette',
      price: 4.99,
      imageUrl: '', // Can be empty string
      description: 'Traditional French baguette, perfect for sandwiches',
      category: 'Bread',
    ),
    const ProductModel(
      id: '',
      name: 'Croissant',
      price: 3.99,
      imageUrl: 'https://example.com/croissant.jpg',
      description: 'Buttery French croissant, flaky and delicious',
      category: 'Pastry',
    ),
    const ProductModel(
      id: '',
      name: 'Chocolate Danish',
      price: 4.50,
      imageUrl: '',
      description: 'Danish pastry filled with rich chocolate',
      category: 'Pastry',
    ),
    const ProductModel(
      id: '',
      name: 'Apple Turnover',
      price: 4.25,
      imageUrl: '',
      description: 'Flaky pastry filled with cinnamon-spiced apples',
      category: 'Pastry',
    ),
    const ProductModel(
      id: '',
      name: 'Chocolate Fudge Cake',
      price: 29.99,
      imageUrl: 'https://example.com/chocolatecake.jpg',
      description: 'Rich chocolate cake with fudge frosting',
      category: 'Cake',
    ),
    const ProductModel(
      id: '',
      name: 'Vanilla Birthday Cake',
      price: 34.99,
      imageUrl: '',
      description: 'Classic vanilla cake with buttercream frosting',
      category: 'Cake',
    ),
    const ProductModel(
      id: '',
      name: 'Red Velvet Cake',
      price: 32.99,
      imageUrl: '',
      description: 'Moist red velvet cake with cream cheese frosting',
      category: 'Cake',
    ),
    const ProductModel(
      id: '',
      name: 'Holiday Fruitcake (Pre-order)',
      price: 39.99,
      imageUrl: '',
      description: 'Traditional holiday fruitcake soaked in brandy',
      category: 'Special',
    ),
    const ProductModel(
      id: '',
      name: 'Custom Wedding Cake',
      price: 199.99,
      imageUrl: '',
      description: 'Custom-designed wedding cake (consultation required)',
      category: 'Special',
    ),
  ];

  int successCount = 0;

  for (var product in bakeryProducts) {
    try {
      final createdProduct = await productDataSource.createProduct(product);
      print(
          '✅ Created product: ${createdProduct.name} (${createdProduct.category}) - \$${createdProduct.price}');
      successCount++;
    } catch (e) {
      print('❌ Failed to create product: ${product.name} - Error: $e');
    }
  }

  print('\n📊 Product Seeding Summary:');
  print('   Total attempted: ${bakeryProducts.length}');
  print('   Successfully created: $successCount');

  // Verify counts by category
  print('\n📦 Product Categories:');
  final categories = ['Bread', 'Pastry', 'Cake', 'Special'];
  for (var category in categories) {
    try {
      final products = await productDataSource.getProductsByCategory(category);
      print('   $category: ${products.length} items');
    } catch (e) {
      print('   $category: Error counting');
    }
  }
}
