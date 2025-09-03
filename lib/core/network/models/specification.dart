class Specification {
  final int id;
  final String name;
  final String? value;
  final String? icon;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Specification({
    required this.id,
    required this.name,
    this.icon,
    this.value,
    this.createdAt,
    this.updatedAt,
  });

  factory Specification.fromJson(Map<String, dynamic> json) {
    return Specification(
      id: json['id'] as int,
      name: json['name'] as String,
      icon: json['icon'] as String?,
      value: json['value'] as String?,
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
      'icon': icon,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'value': value,
    };
  }

  Specification copyWith({
    int? id,
    String? name,
    String? icon,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Specification(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
