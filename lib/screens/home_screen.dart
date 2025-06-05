import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tambay/components/cart_item_component.dart';
// import 'package:tambay/data/dummy_cart.dart';
// import 'package:tambay/models/item.dart';
// import 'package:tambay/data/dummy_items.dart';
import 'package:tambay/provider/products_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ProductProvider>(context, listen: false).fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tambay"),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/search');
                },
                child: Container(
                  width: 220,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.0),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 8),
                      Text("Search...", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/cart");
              },
              icon:
              // cartItemCount > 0 ?
              //   Badge.count(count: cartItemCount, child: Icon(Icons.shopping_cart_outlined),)
              //   :
              Icon(Icons.shopping_cart_outlined),
            ),
          ],
          bottom: TabBar(tabs: [Tab(text: "Shop"), Tab(text: "Featured")]),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<ProductProvider>(
            builder: (context, productProvider, _) {
              if (productProvider.isLoading) {
                return Center(child: CircularProgressIndicator());
              }
              final items = productProvider.items;
              // final featuredItems = productProvider.featuredItems;
              return TabBarView(
                children: [
                  // Shop Tab
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 0.65,
                        ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return CartItemComponent(item: items[index]);
                    },
                  ),
                  // Featured Tab
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 0.65,
                        ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return CartItemComponent(item: items[index]);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
