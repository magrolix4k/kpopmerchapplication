class UserModel {
  final String uid;
  final String email;
  final String username;
  final String? name;
  final String? profileImage;
  final String? bio;
  final bool isVerified;
  final String role;
  final String status;

  UserModel({
    required this.uid,
    required this.email,
    required this.username,
    this.name,
    this.profileImage,
    this.bio,
    required this.isVerified,
    required this.role,
    required this.status,
  });

  // แปลงข้อมูลจาก JSON เป็น UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      username: json['username'],
      name: json['name'],
      profileImage: json['profile_image'],
      bio: json['bio'],
      isVerified: json['is_verified'],
      role: json['role'],
      status: json['status'],
    );
  }
}
