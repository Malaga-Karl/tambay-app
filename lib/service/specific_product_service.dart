import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tambay/models/item.dart';
import 'package:tambay/models/product_image.dart';

class SpecificProductService {
  final dio = Dio(
    BaseOptions(
      headers: {
        'Content-Type': 'application/json',
        'X-Shopify-Access-Token': dotenv.env['SHOPIFY_KEY'],
      },
    ),
  );

  late Item productItem;
  // not dynamic
  // add error handling
  Future<Item> fetchItem(id) async {
    try {
      final response = await dio.get(
        'https://tambay.co/admin/api/2025-04/products/$id.json',
      );

      final dynamic responseData = response.data["product"];

      productItem = Item.fromJson(responseData);

      print(response.data["product"]);
    } catch (err) {
      throw Exception(err);
    }
    return (productItem);
  }
}
