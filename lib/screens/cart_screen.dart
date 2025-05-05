import 'package:flutter/material.dart';
import 'package:tambay/data/dummy_cart.dart';
import 'package:tambay/models/item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    List<Item> dummy_cart_items = dummyCartItemsEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Shopping Cart"),
      ),
      body: dummy_cart_items.isEmpty
          ? Center(
              child: Text(
                "You have no items in your cart. Buy now!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: dummy_cart_items.length,
              itemBuilder: (context, index) {
                final item = dummy_cart_items[index];
                return ListTile(
                  leading: Image.network(
                    item.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(item.name),
                  subtitle: Text("P${item.price}"),
                  trailing: Text("Qty: ${item.quantity}"),
                );
              },
            ),
    );
  }
}