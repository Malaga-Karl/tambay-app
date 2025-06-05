class Variant {
  final int id;
  final int productId;
  final String title;
  final String price;
  final int position;
  final String inventoryPolicy;
  final String? compareAtPrice;
  final String option1;
  final String? option2;
  final String? option3;
  final String createdAt;
  final String updatedAt;
  final bool taxable;
  final String barcode;
  final String fulfillmentService;
  final int grams;
  final String? inventoryManagement;
  final bool requiresShipping;
  final String sku;
  final double weight;
  final String weightUnit;
  final int inventoryItemId;
  final int inventoryQuantity;
  final int oldInventoryQuantity;
  final String adminGraphqlApiId;
  final int? imageId;

  Variant({
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.position,
    required this.inventoryPolicy,
    required this.compareAtPrice,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.createdAt,
    required this.updatedAt,
    required this.taxable,
    required this.barcode,
    required this.fulfillmentService,
    required this.grams,
    required this.inventoryManagement,
    required this.requiresShipping,
    required this.sku,
    required this.weight,
    required this.weightUnit,
    required this.inventoryItemId,
    required this.inventoryQuantity,
    required this.oldInventoryQuantity,
    required this.adminGraphqlApiId,
    required this.imageId,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      id: json['id'],
      productId: json['product_id'],
      title: json['title'],
      price: json['price'],
      position: json['position'],
      inventoryPolicy: json['inventory_policy'],
      compareAtPrice: json['compare_at_price'],
      option1: json['option1'],
      option2: json['option2'],
      option3: json['option3'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      taxable: json['taxable'],
      barcode: json['barcode'],
      fulfillmentService: json['fulfillment_service'],
      grams: json['grams'],
      inventoryManagement: json['inventory_management'],
      requiresShipping: json['requires_shipping'],
      sku: json['sku'],
      weight: (json['weight'] as num).toDouble(),
      weightUnit: json['weight_unit'],
      inventoryItemId: json['inventory_item_id'],
      inventoryQuantity: json['inventory_quantity'],
      oldInventoryQuantity: json['old_inventory_quantity'],
      adminGraphqlApiId: json['admin_graphql_api_id'],
      imageId: json['image_id'],
    );
  }
}
