import 'package:flutter/material.dart';
import 'package:tambay/service/product_service.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: (){
                ProductService().printApiUrl();
            }, 
            child: Text("Display API KEY")),
            TextButton(
              onPressed: (){
                ProductService().fetchItems();
            }, 
            child: Text("Fetch Data"))
          ],
        ),
      ),
    );
  }
}