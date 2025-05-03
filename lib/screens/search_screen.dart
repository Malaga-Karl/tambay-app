import 'package:flutter/material.dart';
import 'package:tambay/models/item.dart';
import 'package:tambay/data/dummy_items.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Item> searchResults = dummyItems; // Show all items by default
  final TextEditingController searchController = TextEditingController();

  void _searchItems(String query) {
    if (query.isEmpty) {
      setState(() {
        searchResults = dummyItems; // Show all items if query is empty
      });
      return;
    }

    final results =
        dummyItems.where((item) {
          final itemName = item.name.toLowerCase();
          final input = query.toLowerCase();
          return itemName.contains(input);
        }).toList();

    setState(() {
      searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Items"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: _searchItems,
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
          searchResults.isEmpty
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
                      item.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item.name),
                    subtitle: Text("P${item.price}"),
                    onTap: () {
                      print("Tapped on ${item.name}");
                    },
                  );
                },
              ),
    );
  }
}
