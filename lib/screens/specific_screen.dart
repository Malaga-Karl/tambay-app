// import 'package:flutter/material.dart';
// import 'package:tambay/models/item.dart';
// import 'package:tambay/service/product_service.dart';

// class SpecificScreen extends StatefulWidget {
//   final int id;
//   const SpecificScreen({super.key, required this.id});

//   @override
//   State<SpecificScreen> createState() => _SpecificScreenState();
// }

// class _SpecificScreenState extends State<SpecificScreen> {
//   Item? item;
//   int quantity = 1;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadItem();
//   }

//   Future<void> _loadItem() async {
//     final fetchedItem = await ProductService().fetchItem(widget.id);
//     setState(() {
//       item = fetchedItem;
//       isLoading = false;
//     });
//   }

//   void _incrementQuantity() {
//     setState(() {
//       quantity++;
//     });
//   }

//   void _decrementQuantity() {
//     if (quantity > 1) {
//       setState(() {
//         quantity--;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading || item == null) {
//       return Scaffold(
//         appBar: AppBar(),
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }
//     return Scaffold(
//       appBar: AppBar(title: Text(item!.title)),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: 200,
//               child: Image.network(item!.image.src, fit: BoxFit.cover),
//             ),
//             const SizedBox(height: 16),
//             // Text(item!.description ?? '', style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(
//                   onPressed: _decrementQuantity,
//                   icon: Icon(Icons.remove),
//                 ),
//                 Text(
//                   "$quantity",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 IconButton(
//                   onPressed: _incrementQuantity,
//                   icon: Icon(Icons.add),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             FilledButton.icon(
//               onPressed: () {
//                 print("Added ${item!.title} with quantity $quantity to cart");
//               },
//               label: Text("Add to Cart"),
//               icon: Icon(Icons.add_shopping_cart),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
