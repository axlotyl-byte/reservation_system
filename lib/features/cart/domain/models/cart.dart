import 'cart_item.dart';

class Cart {
  final List<CartItem> items;

  Cart({this.items = const []});

  double get totalAmount =>
      items.fold(0, (sum, item) => sum + (item.price * item.quantity));
}
