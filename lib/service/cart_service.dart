import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartService {
  static const String _cartKey = 'cart_items';

  Future<void> saveCartItem(int itemId, int quantity) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final cart = prefs.getString(_cartKey);
    Map<String, int> cartItems =
        cart != null ? Map<String, int>.from(jsonDecode(cart)) : {};
    cartItems[itemId.toString()] =
        (cartItems[itemId.toString()] ?? 0) + quantity;
    await prefs.setString(_cartKey, jsonEncode(cartItems));
  }

  Future<Map<String, int>> getCartItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final cart = prefs.getString(_cartKey);
    return cart != null ? Map<String, int>.from(jsonDecode(cart)) : {};
  }
}
