import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tambay/provider/cart_provider.dart';
import 'dart:convert';

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
      body: SizedBox(
        height: 700,
        child: FutureBuilder<Map<String, dynamic>>(
          future: _getSharedPreferencesValues(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error loading cart items"));
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              final cartItems = snapshot.data!;
              return Column(
                children: [
                  // "Select All" Checkbox
                  Consumer<CartProvider>(
                    builder: (context, cartProvider, _) {
                      return CheckboxListTile(
                        title: Text("Select All"),
                        value: cartProvider.isSelectAll,
                        onChanged: (bool? value) {
                          cartProvider.toggleSelectAll(value ?? false, cartItems);
                        },
                      );
                    },
                  ),
                  Expanded(
                    child: ListView(
                      children:
                          cartItems.entries.map((entry) {
                            final itemId = entry.key;
                            final quantity = entry.value;
                            return Consumer<CartProvider>(
                              builder: (context, cartProvider, _) {
                                return ListTile(
                                  leading: Checkbox(
                                    value:
                                        cartProvider.selectedItems[itemId] ??
                                        false,
                                    onChanged: (bool? value) {
                                      cartProvider.toggleItem(
                                        itemId,
                                        value ?? false,
                                      );
                                    },
                                  ),
                                  title: Text("Item ID: $itemId"),
                                  subtitle: Text("Quantity: $quantity"),
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/specific/$itemId', // Navigate to SpecificScreen
                                    );
                                  },
                                );
                              },
                            );
                          }).toList(),
                    ),
                  ),
                  // Checkout Button
                  Consumer<CartProvider>(
                    builder: (context, cartProvider, _) {
                      final isCheckoutEnabled = cartProvider.selectedItems.values
                          .any((isChecked) => isChecked);
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed:
                              isCheckoutEnabled
                                  ? () {
                                    // Handle checkout logic here
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Proceeding to checkout...",
                                        ),
                                      ),
                                    );
                                  }
                                  : null, // Disable button if no items are selected
                          child: Text("Checkout"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isCheckoutEnabled ? Colors.blue : Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ],
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
      ),
    );
  }
}
