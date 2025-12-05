import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item.dart';

class CartStorageService {
  static const _cartKey = 'cartItems';

  Future<void> saveCart(List<CartItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = items.map((item) => item.toMap()).toList();
    await prefs.setString(_cartKey, json.encode(cartData));
  }

  Future<List<CartItem>> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartString = prefs.getString(_cartKey);
    if (cartString == null) {
      return [];
    }
    final List<dynamic> cartData = json.decode(cartString);
    return cartData.map((data) => CartItem.fromMap(data)).toList();
  }

  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }
}
