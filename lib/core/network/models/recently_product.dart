class RecentlyProduct {
  final int productId;
  final String name;
  final String thumbnail;

  RecentlyProduct({
    required this.productId,
    required this.name,
    required this.thumbnail,
  });

  factory RecentlyProduct.fromJson(Map<String, dynamic> json) {
    return RecentlyProduct(
      productId: json['productId'],
      name: json['name'],
      thumbnail: json['thumbnail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'thumbnail': thumbnail,
    };
  }

  RecentlyProduct copyWith({
    int? productId,
    String? name,
    String? thumbnail,
  }) {
    return RecentlyProduct(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }
}
