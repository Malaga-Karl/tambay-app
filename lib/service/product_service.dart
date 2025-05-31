import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final dio = Dio();
class ProductService {
  final token = dotenv.env['SHOPIFY_KEY'];
  void printApiUrl() {
    print(token);
  }

  dynamic fetchItems() async {
    final headers = {
      'Content-Type': 'application/json',
      'X-Shopify-Access-Token': token,
    };

    final response = await dio.get(
      'https://tambay.co/admin/api/2025-04/products.json',
      options: Options(
        headers: headers
      )
    );
    return (response.data["products"]);
  }

  dynamic fetchItem(id) async {
    final headers = {
      'Content-Type': 'application/json',
      'X-Shopify-Access-Token': token,
    };

    final response = await dio.get(
      'https://tambay.co/admin/api/2025-04/products/$id.json',
      options: Options(
        headers: headers
      )
    );
    return (response.data["product"]);
  }
}



