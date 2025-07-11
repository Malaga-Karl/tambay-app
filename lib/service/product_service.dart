import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tambay/models/item.dart';

class ProductService {
  final dio = Dio(
    BaseOptions(
      headers: {
        'Content-Type': 'application/json',
        'X-Shopify-Access-Token': dotenv.env['SHOPIFY_KEY'],
      },
    ),
  );
  List<Item> itemsList = [];

  // not dynamic
  // add error handling
  Future<List<Item>> fetchItems() async {
    try {
      final response = await dio.get(
        'https://tambay.co/admin/api/2025-04/products.json',
      );

      print(response.data["products"]);

      final List<dynamic> responseData = response.data["products"];

      itemsList =
          responseData.map((product) => Item.fromJson(product)).toList();
    } catch (err) {
      throw Exception(err);
    }
    return itemsList;
  }
}
