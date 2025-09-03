import 'package:app_base/core/network/models/brand.dart';
import 'package:app_base/core/network/models/category.dart';
import 'package:app_base/core/network/models/color.dart';
import 'package:app_base/core/network/models/currency.dart';
import 'package:app_base/core/network/models/image_model.dart';
import 'package:app_base/core/network/models/space.dart';
import 'package:app_base/core/network/models/specification.dart';
import 'package:app_base/core/network/models/sub_category.dart';

class Product {
  final int id;
  final String name;
  final String price;
  final bool? isOnSale;
  final String? salePrice;
  final String? url;
  final String? thumbnail;
  final String? pros;
  final String? cons;
  final int? totalLikes;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Brand? brand;
  final Category? category;
  final SubCategory? subCategory;
  final Currency currency;
  final List<Space>? spaces;
  final List<ImageModel>? images;
  final List<Specification>? specifications;
  final List<ColorModel>? colors;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.isOnSale,
    this.salePrice,
    this.url,
    this.thumbnail,
    this.pros,
    this.cons,
    this.totalLikes,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.brand,
    this.category,
    this.subCategory,
    required this.currency,
    this.spaces,
    this.images,
    this.specifications,
    this.colors,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as String,
      isOnSale: json['isOnSale'] as bool?,
      salePrice: json['salePrice'] as String?,
      url: json['url'] as String?,
      thumbnail: json['thumbnail'] as String?,
      pros: json['pros'] as String?,
      cons: json['cons'] as String?,
      totalLikes: json['totalLikes'] as int?,
      description: json['description'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      brand: json['brand'] != null ? Brand.fromJson(json['brand']) : null,
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
      subCategory: json['subCategory'] != null
          ? SubCategory.fromJson(json['subCategory'])
          : null,
      currency: Currency.fromJson(json['currency']),
      spaces: json['spaces'] != null
          ? (json['spaces'] as List)
              .map((space) => Space.fromJson(space))
              .toList()
          : null,
      images: json['images'] != null
          ? (json['images'] as List)
              .map((image) => ImageModel.fromJson(image))
              .toList()
          : null,
      specifications: json['specifications'] != null
          ? (json['specifications'] as List)
              .map((spec) => Specification.fromJson(spec))
              .toList()
          : null,
      colors: json['colors'] != null
          ? (json['colors'] as List)
              .map((color) => ColorModel.fromJson(color))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'isOnSale': isOnSale,
      'salePrice': salePrice,
      'url': url,
      'thumbnail': thumbnail,
      'pros': pros,
      'cons': cons,
      'totalLikes': totalLikes,
      'description': description,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'brand': brand?.toJson(),
      'category': category?.toJson(),
      'subCategory': subCategory?.toJson(),
      'currency': currency.toJson(),
      'spaces': spaces?.map((space) => space.toJson()).toList(),
      'images': images?.map((image) => image.toJson()).toList(),
      'specifications': specifications?.map((spec) => spec.toJson()).toList(),
      'colors': colors?.map((color) => color.toJson()).toList(),
    };
  }

  Product copyWith({
    int? id,
    String? name,
    String? price,
    bool? isOnSale,
    String? salePrice,
    String? url,
    String? thumbnail,
    String? pros,
    String? cons,
    int? totalLikes,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    Brand? brand,
    Category? category,
    SubCategory? subCategory,
    Currency? currency,
    List<Space>? spaces,
    List<ImageModel>? images,
    List<Specification>? specifications,
    List<ColorModel>? colors,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      isOnSale: isOnSale ?? this.isOnSale,
      salePrice: salePrice ?? this.salePrice,
      url: url ?? this.url,
      thumbnail: thumbnail ?? this.thumbnail,
      pros: pros ?? this.pros,
      cons: cons ?? this.cons,
      totalLikes: totalLikes ?? this.totalLikes,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      currency: currency ?? this.currency,
      spaces: spaces ?? this.spaces,
      images: images ?? this.images,
      specifications: specifications ?? this.specifications,
      colors: colors ?? this.colors,
    );
  }
}
