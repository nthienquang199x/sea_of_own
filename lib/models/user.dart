enum UserRole {
  patient,
  staff,
  manager,
  admin;

  static UserRole fromString(String value) {
    return UserRole.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => UserRole.patient,
    );
  }

  String toJson() => name;
}

class User {
  final int id;
  final String fullname;
  final String email;
  final UserRole role;
  final String? avatarUrl;
  final bool isVerified;
  final String? referralCode;
  final String? phone;
  final DateTime? birth;
  final InBody? inBody;

  User({
    required this.id,
    required this.fullname,
    required this.email,
    required this.role,
    this.avatarUrl,
    required this.isVerified,
    this.referralCode,
    this.phone,
    this.birth,
    this.inBody,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullname: json['full_name'],
      email: json['email'],
      role: UserRole.fromString(json['role']),
      avatarUrl: json['avatar_url'],
      isVerified: json['is_verified'],
      referralCode: json['referral_code'],
      phone: json['phone'],
      birth: json['birth'] != null ? DateTime.parse(json['birth']) : null,
      inBody: json['inbody'] != null
          ? InBody.fromJson(json['inbody'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullname,
      'email': email,
      'role': role.toJson(),
      'avatar_url': avatarUrl,
      'is_verified': isVerified,
      'referral_code': referralCode,
      'phone': phone,
      'birth': birth?.toIso8601String().split('T').first,
      'in_body': inBody?.toJson(),
    };
  }

  User copyWith({
    int? id,
    String? fullname,
    String? email,
    UserRole? role,
    String? avatarUrl,
    bool? isVerified,
    String? referralCode,
    String? phone,
    DateTime? birth,
    InBody? inBody,
  }) {
    return User(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      role: role ?? this.role,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isVerified: isVerified ?? this.isVerified,
      referralCode: referralCode ?? this.referralCode,
      phone: phone ?? this.phone,
      birth: birth ?? this.birth,
      inBody: inBody ?? this.inBody,
    );
  }
}

class InBody {
  final double weight;
  final double bodyFat;
  final double bmi;

  InBody({required this.weight, required this.bodyFat, required this.bmi});

  factory InBody.fromJson(Map<String, dynamic> json) {
    return InBody(
      weight: (json['weight'] ?? 0).toDouble(),
      bodyFat: (json['body_fat'] ?? 0).toDouble(),
      bmi: (json['bmi'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weight': weight,
      'body_fat': bodyFat,
      'bmi': bmi,
    };
  }
}
