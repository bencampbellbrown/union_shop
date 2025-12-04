class CartItem {
  final String productId;
  final String title;
  final String price;
  final String? salePrice;
  final int quantity;
  final String? selectedColor;
  final String? selectedSize;
  final String imageUrl;
  final bool isOnSale;

  CartItem({
    required this.productId,
    required this.title,
    required this.price,
    this.salePrice,
    required this.quantity,
    this.selectedColor,
    this.selectedSize,
    required this.imageUrl,
    this.isOnSale = false,
  });

  /// Create a copy with modified fields
  CartItem copyWith({
    int? quantity,
    String? selectedColor,
    String? selectedSize,
  }) {
    return CartItem(
      productId: productId,
      title: title,
      price: price,
      salePrice: salePrice,
      quantity: quantity ?? this.quantity,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedSize: selectedSize ?? this.selectedSize,
      imageUrl: imageUrl,
      isOnSale: isOnSale,
    );
  }
}
