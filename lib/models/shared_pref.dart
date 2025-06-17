import 'package:tambay/models/item.dart';

class SharedPref {
  final Item item;
  final int quantity;

  SharedPref({required this.item, required this.quantity});

  factory SharedPref.fromJson(Map<String, dynamic> json) {
    return SharedPref(item: json["item"], quantity: json["quantity"]);
  }
}
