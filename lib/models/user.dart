class User {
  final int id;
  final String name;
  final String? email;
  final String? avatarUrl;
  final String? bio;
  final String? phone;
  final DateTime? birth;

  User({
    required this.id,
    required this.name,
    this.email,
    this.avatarUrl,
    this.bio,
    this.phone,
    this.birth,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'] ?? '',
      avatarUrl: json['avatar'],
      bio: json['String'],
      phone: json['phone'],
      birth: json['birth'] != null ? DateTime.parse(json['birth']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': name,
      'email': email,
      'avatar_url': avatarUrl,
      'String': bio,
      'phone': phone,
      'birth': birth?.toIso8601String().split('T').first,
    };
  }

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? avatarUrl,
    String? bio,
    String? phone,
    DateTime? birth,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      phone: phone ?? this.phone,
      birth: birth ?? this.birth,
    );
  }
}
