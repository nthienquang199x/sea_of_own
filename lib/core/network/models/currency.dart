class Currency {
  final int id;
  final String name;
  final String? code;
  final String? symbol;
  final bool? isDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Currency({
    required this.id,
    required this.name,
    this.code,
    this.symbol,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json['id'] as int,
      name: json['name'] as String,
      code: json['code'] as String?,
      symbol: json['symbol'] as String?,
      isDefault: json['isDefault'] as bool?,
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
      'code': code,
      'symbol': symbol,
      'is_default': isDefault,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Currency copyWith({
    int? id,
    String? name,
    String? code,
    String? symbol,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Currency(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      symbol: symbol ?? this.symbol,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
