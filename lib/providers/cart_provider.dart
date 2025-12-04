import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.length;

  int get totalQuantity => _items.fold(0, (sum, item) => sum + item.quantity);

  /// Add item to cart or update quantity if exists
  void addItem(CartItem cartItem) {
    final existingIndex = _items.indexWhere((item) =>
        item.productId == cartItem.productId &&
        item.selectedColor == cartItem.selectedColor &&
        item.selectedSize == cartItem.selectedSize);

    if (existingIndex >= 0) {
      // Update quantity if product with same options exists
      _items[existingIndex] = _items[existingIndex].copyWith(
          quantity: _items[existingIndex].quantity + cartItem.quantity);
    } else {
      // Add new item
      _items.add(cartItem);
    }
    notifyListeners();
  }

  /// Remove item from cart by index
  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  /// Update item quantity
  void updateQuantity(int index, int quantity) {
    if (index >= 0 && index < _items.length) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index] = _items[index].copyWith(quantity: quantity);
      }
      notifyListeners();
    }
  }

  /// Clear entire cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  /// Calculate subtotal based on item prices and quantities
  /// Uses sale price if item is on sale, otherwise uses regular price
  double getSubtotal() {
    return _items.fold(0.0, (sum, item) {
      final priceStr = item.isOnSale && item.salePrice != null
          ? item.salePrice!
          : item.price;
      final price = double.tryParse(priceStr.replaceAll('£', '')) ?? 0.0;
      return sum + (price * item.quantity);
    });
  }

  /// Calculate total
  double getTotal() {
    return getSubtotal();
  }
}
