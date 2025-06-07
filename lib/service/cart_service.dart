import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartService {
  static const String _cartKey = 'cart_items';

  Future<void> saveCartItem(int itemId, int quantity) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final cart = prefs.getString(_cartKey);

    Map<String, dynamic> cartItems =
        cart != null ? Map<String, dynamic>.from(jsonDecode(cart)) : {};

    final idStr = itemId.toString();

    if (cartItems.containsKey(idStr) && cartItems[idStr] is Map) {
      cartItems[idStr]["quantity"] =
          (cartItems[idStr]["quantity"] ?? 0) + quantity;
    } else {
      cartItems[idStr] = {"quantity": quantity};
    }
    await prefs.setString(_cartKey, jsonEncode(cartItems));
  }

  Future<Map<String, int>> getCartItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final cart = prefs.getString(_cartKey);
    return cart != null ? Map<String, int>.from(jsonDecode(cart)) : {};
  }

  Future<void> clearPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
