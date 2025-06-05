import 'package:flutter/material.dart';
import 'package:tambay/models/item.dart';
import 'package:tambay/service/cart_service.dart';

class CartItemComponent extends StatelessWidget {
  const CartItemComponent({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: InkWell(
        onTap: () {
          print("clicked item ${item.id}");
          Navigator.pushNamed(context, "/specific/${item.id}");
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 2),
          ),
          child: Column(
            children: [
              Container(height:160 , child:Image.network(item.image.src, fit: BoxFit.cover,)),
              Text(item.title),
              Text("P${item.variants[0].price}"),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: () async {
                    try {
                      // Add the item to the cart using the cart service
                      await CartService().saveCartItem(
                        item.id,
                        1,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Added ${item.title} to cart"),
                        ),
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
                      borderRadius:
                          BorderRadius.all(Radius.circular(5)), // Makes the button rectangular
                    ),
                  ),  
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
