class UserModel {
  final String uid;
  final String email;
  final String? name;
  final String username;
  final String? profileImage;
  final String? bio;
  final bool isVerified;
  final String role;
  final String status;
  final DateTime? lastLoginAt;

  UserModel({
    required this.uid,
    required this.email,
    this.name,
    required this.username,
    this.profileImage,
    this.bio,
    this.isVerified = false,
    this.role = 'user',
    this.status = 'active',
    this.lastLoginAt,
  });

  // สร้างจาก JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
      username: json['username'],
      profileImage: json['profile_image'],
      bio: json['bio'],
      isVerified: json['is_verified'] == 1,
      role: json['role'],
      status: json['status'],
      lastLoginAt: json['last_login_at'] != null
          ? DateTime.parse(json['last_login_at'])
          : null,
    );
  }

  // แปลงเป็น JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'username': username,
      'profile_image': profileImage,
      'bio': bio,
      'is_verified': isVerified ? 1 : 0,
      'role': role,
      'status': status,
      'last_login_at': lastLoginAt?.toIso8601String(),
    };
  }
}
