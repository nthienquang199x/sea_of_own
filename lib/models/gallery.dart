class Gallery {
  final String id;
  final String url;
  final DateTime createdAt;

  Gallery({required this.id, required this.url, required this.createdAt});

  factory Gallery.fromJson(Map<String, dynamic> json) {
    return Gallery(
      id: json['id'] as String,
      url: (json['url'] ?? json['file_url']) as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
