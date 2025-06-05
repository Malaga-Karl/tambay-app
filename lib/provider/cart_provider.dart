import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  Map<String, bool> selectedItems = {}; // Track selected checkboxes
  bool isSelectAll = false; // Track the state of the "Select All" checkbox

  void toggleSelectAll(bool value, Map<String, dynamic> cartItems) {
    isSelectAll = value;
    selectedItems = {for (var key in cartItems.keys) key: isSelectAll};
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  void toggleItem(String itemId, bool value) {
    selectedItems[itemId] = value;
    // Update "Select All" state
    isSelectAll = selectedItems.values.every((isChecked) => isChecked);
    notifyListeners(); // Notify listeners to rebuild the UI
  }
}
