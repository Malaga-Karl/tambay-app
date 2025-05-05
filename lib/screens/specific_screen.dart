import 'package:flutter/material.dart';
import 'package:tambay/data/dummy_items.dart';
import 'package:tambay/models/item.dart';

class SpecificScreen extends StatefulWidget {
  final Item item; // Store the item directly

  SpecificScreen({super.key, required int id})
    : item = dummyItems.firstWhere(
        (element) => element.id == id,
      ); // Find the item in the constructor

  @override
  State<SpecificScreen> createState() => _SpecificScreenState();
}

class _SpecificScreenState extends State<SpecificScreen> {
  int quantity = 1; // Default quantity

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.item.name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              child: Image.network(widget.item.imageUrl, fit: BoxFit.cover),
            ),
            const SizedBox(height: 16),
            Text(
              widget.item.description,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _decrementQuantity,
                  icon: Icon(Icons.remove),
                ),
                Text(
                  "$quantity",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: _incrementQuantity,
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () {
                print(
                  "Added ${widget.item.name} with quantity $quantity to cart",
                );
              },
              label: Text("Add to Cart"),
              icon: Icon(Icons.add_shopping_cart),
            ),
          ],
        ),
      ),
    );
  }
}
