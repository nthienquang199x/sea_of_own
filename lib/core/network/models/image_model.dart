class ImageModel {
  final int id;
  final String url;

  ImageModel({
    required this.id,
    required this.url,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'] as int,
      url: json['url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
    };
  }

  ImageModel copyWith({
    int? id,
    String? url,
  }) {
    return ImageModel(
      id: id ?? this.id,
      url: url ?? this.url,
    );
  }
}
