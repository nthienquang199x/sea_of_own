import 'package:app_base/core/network/models/category.dart';

class SubCategory {
  final int id;
  final String name;
  final Category? category;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SubCategory({
    required this.id,
    required this.name,
    required this.category,
    this.createdAt,
    this.updatedAt,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] != null
          ? Category.fromJson(json['category'] as Map<String, dynamic>)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category?.toJson(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
