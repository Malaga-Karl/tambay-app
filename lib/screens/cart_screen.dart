import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:tambay/models/item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  Future<Map<String, dynamic>> _getSharedPreferencesValues() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cart_items');
    if (cartData != null) {
      return jsonDecode(cartData); // Parse the JSON string into a Map
    }
    return {}; // Return an empty map if no data is found
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Shopping Cart")),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getSharedPreferencesValues(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading cart items"));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final cartItems = snapshot.data!;
            return ListView(
              children:
                  cartItems.entries.map((entry) {
                    final itemId = entry.key;
                    final quantity = entry.value;
                    return ListTile(
                      title: Text("Item ID: $itemId"),
                      subtitle: Text("Quantity: $quantity"),
                    );
                  }).toList(),
            );
          } else {
            return Center(
              child: Text(
                "Your cart is empty. Add items to your cart!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }
        },
      ),
    );
  }
}
