class ColorModel {
  final int id;
  final String name;
  final String? hexCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ColorModel({
    required this.id,
    required this.name,
    this.hexCode,
    this.createdAt,
    this.updatedAt,
  });

  factory ColorModel.fromJson(Map<String, dynamic> json) {
    return ColorModel(
      id: json['id'] as int,
      name: json['name'] as String,
      hexCode: json['hexCode'] as String?,
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
      'hexCode': hexCode,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  ColorModel copyWith({
    int? id,
    String? name,
    String? hexCode,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ColorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      hexCode: hexCode ?? this.hexCode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
