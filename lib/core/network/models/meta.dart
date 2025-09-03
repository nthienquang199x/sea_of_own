class Meta {
  final int page;
  final int perPage;
  final int totalData;
  final int totalPage;

  Meta({
    required this.page,
    required this.perPage,
    required this.totalData,
    required this.totalPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      page: json['page'] as int,
      perPage: json['perPage'] as int,
      totalData: json['totalData'] as int,
      totalPage: json['totalPage'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'perPage': perPage,
      'totalData': totalData,
      'totalPage': totalPage,
    };
  }
}
