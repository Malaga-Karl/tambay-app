import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  double _calculateTotalPrice(
    Map<String, dynamic> cartItems,
    CartProvider cartProvider,
  ) {
    double total = 0.0;
    cartItems.forEach((itemId, value) {
      if (cartProvider.selectedItems[itemId] == true) {
        // Decode item and quantity
        final dynamic rawData = value['data'];
        final itemMap = rawData is String ? jsonDecode(rawData) : rawData;
        final item = Item.fromJson(itemMap);
        final quantity = int.tryParse(value['quantity'].toString()) ?? 1;
        final price = double.tryParse(item.variants[0].price.toString()) ?? 0.0;
        total += price * quantity;
      }
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView(
                        children:
                            cartItems.entries.map((entry) {
                              final itemId = entry.key;
                              final value = entry.value;
                              if (value == null ||
                                  value['quantity'] == null ||
                                  value['data'] == null) {
                                return ListTile(
                                  title: Text("Invalid item"),
                                  subtitle: Text(
                                    "This item could not be loaded.",
                                  ),
                                );
                              }
                              // Decode the item data from JSON string to Map
                              final itemMap = jsonDecode(value['data']);
                              final quantity = jsonDecode(
                                value['quantity'].toString(),
                              );
                              final item = Item.fromJson(itemMap);

                              return Consumer<CartProvider>(
                                builder: (context, cartProvider, _) {
                                  return InkWell(
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 24,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey.shade300,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color.fromARGB(
                                                  57,
                                                  0,
                                                  0,
                                                  0,
                                                ),
                                                blurRadius: 10,
                                                offset: Offset(0, 6),
                                              ),
                                            ],
                                            color: Colors.white,
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            child: Image.network(
                                              item.image.src,
                                              width: deviceWidth * 0.3,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.title,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.titleLarge!.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'P${item.variants[0].price.toString()}',
                                              style: Theme.of(
                                                context,
                                              ).textTheme.titleMedium!.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "Quantity: ${quantity.toString()}",
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Checkbox(
                                          value:
                                              cartProvider
                                                  .selectedItems[itemId] ??
                                              false,
                                          onChanged: (bool? value) {
                                            cartProvider.toggleItem(
                                              itemId,
                                              value ?? false,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
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
                  ),
                  Consumer<CartProvider>(
                    builder: (context, cartProvider, _) {
                      final totalPrice = _calculateTotalPrice(
                        cartItems,
                        cartProvider,
                      );
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Total: ",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "₱${totalPrice.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  // Checkout Button
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
                                isCheckoutEnabled
                                    ? const Color.fromARGB(255, 0, 0, 0)
                                    : Colors.grey,
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
