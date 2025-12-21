class CartItem {
  final String productId;
  final String productName;
  final String? variant;
  final int quantity;
  final double price;

  CartItem({
    required this.productId,
    required this.productName,
    this.variant,
    required this.quantity,
    required this.price,
  });
}
