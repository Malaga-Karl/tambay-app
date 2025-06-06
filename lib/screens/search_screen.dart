import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tambay/models/item.dart';
// import 'package:tambay/provider/product_provider.dart';
import 'package:tambay/provider/products_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Item> searchResults = [];
  final TextEditingController searchController = TextEditingController();

  void _searchItems(String query, List<Item> allItems) {
    if (query.isEmpty) {
      setState(() {
        searchResults = allItems; // Show all items if query is empty
      });
      return;
    }

    final results =
        allItems.where((item) {
          final itemName = item.title.toLowerCase();
          final input = query.toLowerCase();
          return itemName.contains(input);
        }).toList();

    setState(() {
      searchResults = results;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final allItems = Provider.of<ProductProvider>(context, listen: false).items;
    searchResults = allItems; // Initialize with all fetched items
  }

  @override
  Widget build(BuildContext context) {
    final allItems = Provider.of<ProductProvider>(context).items;

    return Scaffold(
      appBar: AppBar(
        title: Text("Search Items"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (query) => _searchItems(query, allItems),
              decoration: InputDecoration(
                hintText: "Search for items...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body:
          allItems.isEmpty
              ? Center(child: CircularProgressIndicator())
              : searchResults.isEmpty
              ? Center(
                child: Text(
                  "No items found.",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final item = searchResults[index];
                  return ListTile(
                    leading: Image.network(
                      item.image.src,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item.title),
                    subtitle: Text("P${item.variants[0].price}"),
                    onTap: () {
                      print("Tapped on ${item.title}");
                    },
                  );
                },
              ),
    );
  }
}
