import 'package:flutter/material.dart';
import 'package:tambay/models/item.dart';
import 'package:tambay/service/product_service.dart';

class ProductProvider extends ChangeNotifier {
  List<Item> _items = [];
  bool _isLoading = false;

  List<Item> get items => _items;
  bool get isLoading => _isLoading;
  // List<Item> get featuredItems =>
  //     _items.where((item) => item.isFeatured == true).toList();

  Future<void> fetchItems() async {
    _isLoading = true;
    notifyListeners();
    _items = await ProductService().fetchItems();
    _isLoading = false;
    notifyListeners();
  }
}
