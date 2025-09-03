class Collection {
  final int id;
  final String name;
  final String? thumbnail;
  final bool isFeatured;
  final int order;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Collection({
    required this.id,
    required this.name,
    this.thumbnail,
    required this.isFeatured,
    required this.order,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      id: json['id'] as int,
      name: json['name'] as String,
      thumbnail: json['thumbnail'] as String?,
      isFeatured: json['isFeatured'] as bool,
      order: json['order'] as int,
      description: json['description'] as String?,
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
      'thumbnail': thumbnail,
      'isFeatured': isFeatured,
      'order': order,
      'description': description,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Collection copyWith({
    int? id,
    String? name,
    String? thumbnail,
    bool? isFeatured,
    int? order,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Collection(
      id: id ?? this.id,
      name: name ?? this.name,
      thumbnail: thumbnail ?? this.thumbnail,
      isFeatured: isFeatured ?? this.isFeatured,
      order: order ?? this.order,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
