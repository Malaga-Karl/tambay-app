import 'package:flutter/material.dart';
import 'package:tambay/components/cart_item_component.dart';
import 'package:tambay/data/dummy_cart.dart';
import 'package:tambay/models/item.dart';
import 'package:tambay/data/dummy_items.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {

    List<Item> dummy_items = dummyItems;
    List<Item> featuredItems = dummy_items.where((item) => item.isFeatured == true).toList();
    int cartItemCount = dummyCartItems.length;

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tambay"),
          actions: [
            IconButton(onPressed: (){Navigator.pushNamed(context, '/search');}, icon: Icon(Icons.search)),
            IconButton(
              onPressed: (){Navigator.pushNamed(context, "/cart");}, 
              icon: cartItemCount > 0 ? 
                Badge.count(count: cartItemCount, child: Icon(Icons.shopping_cart_outlined),)
                : 
                Icon(Icons.shopping_cart_outlined)
              )
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: "Shop",),
              Tab(text: "Featured",)
            ] 
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            children: [
              Center(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0, // Spacing between columns
                    mainAxisSpacing: 10.0, // Spacing between rows
                    childAspectRatio: 0.65, // Aspect ratio of each item
                  ),
                  itemCount: dummy_items.length,
                  itemBuilder: (context, index) {
                    return CartItemComponent(dummyItem: dummy_items[index]);
                  },
                )
              ),
              Center(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0, // Spacing between columns
                    mainAxisSpacing: 10.0, // Spacing between rows
                    childAspectRatio: 0.65, // Aspect ratio of each item
                  ),
                  itemCount: featuredItems.length,
                  itemBuilder: (context, index) {
                    return CartItemComponent(dummyItem: featuredItems[index]);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

