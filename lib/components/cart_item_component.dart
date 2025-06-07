import 'package:flutter/material.dart';
import 'package:tambay/models/item.dart';
import 'package:tambay/service/cart_service.dart';

class CartItemComponent extends StatelessWidget {
  const CartItemComponent({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(57, 0, 0, 0),
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
        color: Colors.white,
      ),
      child: SizedBox(
        child: InkWell(
          onTap: () {
            print("clicked item ${item.id}");
            Navigator.pushNamed(context, "/specific/${item.id}");
          },
          child: Column(
            children: [
              Container(
                height: deviceHeight * 0.2,
                child: Image.network(item.image.src, fit: BoxFit.cover),
              ),
              Text(item.title),
              Text("P${item.variants[0].price}"),
              SizedBox(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      // Add the item to the cart using the cart service
                      await CartService().saveCartItem(item.id, 1);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Added ${item.title} to cart")),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed to add to cart: $e")),
                      );
                    }
                  },
                  label: Text("Add to Cart"),
                  icon: Icon(Icons.add_shopping_cart_outlined),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ), // Makes the button rectangular
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
