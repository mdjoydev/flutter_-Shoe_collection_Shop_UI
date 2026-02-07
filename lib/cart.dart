class CartItem {
  final String name;
  final String price;
  final String imagePath;
  final int size;

  CartItem({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.size,
  });
}

final List<CartItem> cartItems = [];
