class SharedPref {
  final String title;
  final int quantity;

  SharedPref({required this.title, required this.quantity});

  factory SharedPref.fromJson(Map<String, dynamic> json) {
    return SharedPref(title: json["title"], quantity: json["quantity"]);
  }
}
