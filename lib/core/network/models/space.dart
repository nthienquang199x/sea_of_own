class Space {
  final int id;
  final String name;
  final String? thumnail;
  final int? order;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Space({
    required this.id,
    required this.name,
    this.thumnail,
    this.order,
    this.createdAt,
    this.updatedAt,
  });

  factory Space.fromJson(Map<String, dynamic> json) {
    return Space(
      id: json['id'] as int,
      name: json['name'] as String,
      thumnail: json['thumnail'] as String?,
      order: json['order'] as int?,
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
      'thumnail': thumnail,
      'order': order,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Space copyWith({
    int? id,
    String? name,
    String? thumnail,
    int? order,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Space(
      id: id ?? this.id,
      name: name ?? this.name,
      thumnail: thumnail ?? this.thumnail,
      order: order ?? this.order,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
