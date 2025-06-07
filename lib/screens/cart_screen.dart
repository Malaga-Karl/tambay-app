import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tambay/models/item.dart';
import 'package:tambay/models/shared_pref.dart';
import 'package:tambay/provider/cart_provider.dart';
import 'dart:convert';

import 'package:tambay/service/cart_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
    var deviceHeight = MediaQuery.of(context).size.height;
    // var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("Your Shopping Cart")),
      body: SizedBox(
        height: deviceHeight * 0.8,
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
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Select All"),
                          Checkbox(
                            value: cartProvider.isSelectAll,
                            onChanged: (bool? value) {
                              cartProvider.toggleSelectAll(
                                value ?? false,
                                cartItems,
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  Expanded(
                    child: ListView(
                      children:
                          cartItems.entries.map((entry) {
                            final itemId = entry.key;
                            final value = entry.value;
                            if (value == null) {
                              return ListTile(
                                title: Text("Invalid item"),
                                subtitle: Text(
                                  "This item could not be loaded.",
                                ),
                              );
                            }
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
                                  title: Text(itemId),
                                  subtitle: Text(value.toString()),
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
                  ElevatedButton(
                    onPressed: () async {
                      await CartService().clearPrefs();
                      setState(() {}); // <-- This will refresh the screen
                    },
                    child: Text("Delete All Items in Cart"),
                  ),
                  Consumer<CartProvider>(
                    builder: (context, cartProvider, _) {
                      final isCheckoutEnabled = cartProvider
                          .selectedItems
                          .values
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
