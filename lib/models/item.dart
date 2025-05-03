class Item {
  late int id; // Unique identifier for the item
  late String name; // Name of the item
  late double price; // Price of the item
  late String description; // Description of the item
  late String imageUrl; // URL for the item's image (optional)
  late int quantity; // Quantity of the item (optional, for cart purposes)
  late bool? isFeatured;

  Item({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    this.imageUrl = '',
    this.quantity = 1,
    this.isFeatured = false
  });
}
