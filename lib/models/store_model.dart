//lib/models/store_model.dart

class StoreModel {
  final String ownerId;
  final String sid;
  final String? name;
  final String? username;
  final String? profileImage;
  final String? bio;
  final DateTime? createAt;
  final int? followers;
  final int? following;

  StoreModel({
    required this.ownerId,
    required this.sid,
    this.name,
    required this.username,
    this.profileImage,
    this.bio,
    this.createAt,
    this.followers,
    this.following,
  });

  // สร้างจาก JSON
  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      ownerId: json['owner_id'],
      sid: json['sid'],
      username: json['username'],
      name: json['name'],
      profileImage: json['profile_image'],
      bio: json['bio'],
      createAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  // แปลงเป็น JSON
  Map<String, dynamic> toJson() {
    return {
      'ownerId': ownerId,
      'sid': sid,
      'name': name,
      'username': username,
      'profile_image': profileImage,
      'bio': bio,
      'craetaAt': createAt?.toIso8601String(),
    };
  }
}
