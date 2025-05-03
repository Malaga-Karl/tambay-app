import 'package:flutter/material.dart';
import 'package:tambay/models/item.dart';

class CartItemComponent extends StatelessWidget {
  const CartItemComponent({super.key, required this.dummyItem});

  final Item dummyItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: InkWell(
        onTap: () {print("clicked item ${dummyItem.id}");},
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 2),
          ),
          child: Column(
            children: [
              Container(height:200 , child:Image.network(dummyItem.imageUrl, fit: BoxFit.cover,)),
              Text(dummyItem.name),
              Text("P${dummyItem.price}"),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: (){
                    print("added to cart item ${dummyItem.id}");
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
