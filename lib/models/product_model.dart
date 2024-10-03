import 'dart:convert';

class ProductModel {
  final int id;
  final String sid;
  final String textId;
  final String text;
  final double price;
  final DateTime createdAt;
  final List<String>? mediaUrls;
  final int views;
  final String? url;
  final List<String>? tags;
  final String groupName;
  final DateTime updatedAt;
  final String? ownerId;

  // Constructor
  ProductModel({
    required this.id,
    required this.sid,
    required this.textId,
    required this.text,
    required this.price,
    required this.createdAt,
    this.mediaUrls,
    this.views = 0,
    this.url,
    this.tags,
    required this.groupName,
    required this.updatedAt,
    this.ownerId,
  });

  // ฟังก์ชันสำหรับแปลงข้อมูลจาก JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      sid: json['sid'],
      textId: json['text_id'],
      text: json['text'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      createdAt: DateTime.parse(json['created_at']),
      mediaUrls: json['media_urls'] != null
          ? List<String>.from(json['media_urls'])
          : null,
      views: json['views'] ?? 0,
      url: json['url'],
      tags: json['tag'] != null ? List<String>.from(json['tag']) : null,
      groupName: json['group_name'],
      updatedAt: DateTime.parse(json['updated_at']),
      ownerId: json['owner_id'] ?? '',
    );
  }

  // ฟังก์ชันสำหรับแปลงข้อมูลเป็น JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sid': sid,
      'owner_id': ownerId,
      'text_id': textId,
      'text': text,
      'price': price,
      'created_at': createdAt.toIso8601String(),
      'media_urls': mediaUrls != null ? jsonEncode(mediaUrls) : null,
      'views': views,
      'url': url,
      'tag': tags != null ? jsonEncode(tags) : null,
      'group_name': groupName,
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
