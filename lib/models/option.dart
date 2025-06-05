class Option {
  final int id;
  final int productId;
  final String name;
  final int position;
  final List<String> values;

  Option({
    required this.id,
    required this.productId,
    required this.name,
    required this.position,
    required this.values,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      productId: json['product_id'],
      name: json['name'],
      position: json['position'],
      values: List<String>.from(json['values']),
    );
  }
}
