class ProductImage {
  final int id;
  final String? alt;
  final int position;
  final int productId;
  final String createdAt;
  final String updatedAt;
  final String adminGraphqlApiId;
  final int width;
  final int height;
  final String src;
  final List<dynamic> variantIds;

  ProductImage({
    required this.id,
    required this.alt,
    required this.position,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
    required this.adminGraphqlApiId,
    required this.width,
    required this.height,
    required this.src,
    required this.variantIds,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      alt: json['alt'],
      position: json['position'],
      productId: json['product_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      adminGraphqlApiId: json['admin_graphql_api_id'],
      width: json['width'],
      height: json['height'],
      src: json['src'],
      variantIds: List<dynamic>.from(json['variant_ids']),
    );
  }
}
