import 'package:tambay/models/option.dart';
import 'package:tambay/models/product_image.dart';
import 'package:tambay/models/variant.dart';

class Item {
  final int id;
  final String title;
  final String bodyHtml;
  final String vendor;
  final String productType;
  final String createdAt;
  final String handle;
  final String updatedAt;
  final String publishedAt;
  final String templateSuffix;
  final String publishedScope;
  final String tags;
  final String status;
  final String adminGraphqlApiId;
  final List<Variant> variants;
  final List<Option> options;
  final List<ProductImage> images;
  final ProductImage image;

  Item({
    required this.id,
    required this.title,
    required this.bodyHtml,
    required this.vendor,
    required this.productType,
    required this.createdAt,
    required this.handle,
    required this.updatedAt,
    required this.publishedAt,
    required this.templateSuffix,
    required this.publishedScope,
    required this.tags,
    required this.status,
    required this.adminGraphqlApiId,
    required this.variants,
    required this.options,
    required this.images,
    required this.image,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      title: json['title'],
      bodyHtml: json['body_html'],
      vendor: json['vendor'],
      productType: json['product_type'],
      createdAt: json['created_at'],
      handle: json['handle'],
      updatedAt: json['updated_at'],
      publishedAt: json['published_at'],
      templateSuffix: json['template_suffix'],
      publishedScope: json['published_scope'],
      tags: json['tags'],
      status: json['status'],
      adminGraphqlApiId: json['admin_graphql_api_id'],
      variants:
          (json['variants'] as List).map((v) => Variant.fromJson(v)).toList(),
      options:
          (json['options'] as List).map((o) => Option.fromJson(o)).toList(),
      images:
          (json['images'] as List)
              .map((img) => ProductImage.fromJson(img))
              .toList(),
      image: ProductImage.fromJson(json['image']),
    );
  }
}
