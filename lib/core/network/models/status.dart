class Status {
  final int id;
  final String name;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Status({
    required this.id,
    required this.name,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: json['id'] as int,
      name: json['name'] as String,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Status copyWith({
    int? id,
    String? name,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Status(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
