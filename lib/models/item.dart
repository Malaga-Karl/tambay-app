class Item {
  late int id; // Unique identifier for the item
  late String name; // Name of the item
  late double price; // Price of the item
  late String description; // Description of the item
  late String imageUrl; // URL for the item's image (optional)
  late int quantity; // Quantity of the item (optional, for cart purposes)
  late bool? isFeatured; // Indicates if the item is featured

  Item({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    this.imageUrl = '',
    this.quantity = 1,
    this.isFeatured = false,
  });

  // Convert an Item object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'isFeatured': isFeatured,
    };
  }

  // Create an Item object from a JSON map
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      imageUrl: json['imageUrl'] ?? '',
      quantity: json['quantity'] ?? 1,
      isFeatured: json['isFeatured'] ?? false,
    );
  }
}
