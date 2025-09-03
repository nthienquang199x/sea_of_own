class Brand {
  final int id;
  final String name;
  final String? logo;
  final String? website;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Brand({
    required this.id,
    required this.name,
    this.logo,
    this.website,
    this.createdAt,
    this.updatedAt,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'] as int,
      name: json['name'] as String,
      logo: json['logo'] as String?,
      website: json['website'] as String?,
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
      'logo': logo,
      'website': website,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Brand copyWith({
    int? id,
    String? name,
    String? logo,
    String? website,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Brand(
      id: id ?? this.id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      website: website ?? this.website,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
