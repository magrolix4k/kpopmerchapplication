import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kpopmerchapplication/presentation/controllers/product_controller.dart';

class ProductListScreen extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: Obx(() {
        if (productController.products.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        // แสดงรายการสินค้า
        return ListView.builder(
          itemCount: productController.products.length,
          itemBuilder: (context, index) {
            var productWithStore = productController.products[index];
            var product = productWithStore['product']; // ข้อมูลสินค้า
            var storeName = productWithStore['store_name'] ?? 'Unknown store';
            var storeUsername =
                productWithStore['store_username'] ?? 'Unknown username';
            var storeProfileImage =
                productWithStore['store_profile_image'] ?? '';
            var mediaUrls = product['media_urls']; // ตรวจสอบ media_urls
            var createdAt = product['created_at'] != null
                ? DateTime.parse(product['created_at']).toLocal()
                : null;

            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ส่วนหัวของโพสต์: รูปโปรไฟล์, ชื่อร้าน และปุ่ม More
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          storeProfileImage.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: storeProfileImage,
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    backgroundImage: imageProvider,
                                    radius: 24,
                                  ),
                                  placeholder: (context, url) =>
                                      const CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Colors.grey,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                )
                              : const CircleAvatar(
                                  radius: 24,
                                  child: Icon(Icons.store),
                                ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  storeName,
                                  style: const TextStyle(
                                    fontFamily: 'IBM Plex Sans Thai',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  storeUsername,
                                  style: const TextStyle(
                                    fontFamily: 'IBM Plex Sans Thai',
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.more_vert),
                            onPressed: () {
                              // เปิดเมนูเพิ่มเติม
                            },
                          ),
                        ],
                      ),
                    ),
                    const Divider(thickness: 1), // เส้นแบ่ง

                    // ส่วนแสดงรูปภาพสินค้า
                    if (mediaUrls != null && mediaUrls.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SizedBox(
                          height: 250,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: mediaUrls.length,
                            itemBuilder: (context, mediaIndex) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: CachedNetworkImage(
                                    imageUrl: mediaUrls[mediaIndex],
                                    placeholder: (context, url) => Container(
                                      width: 250,
                                      height: 250,
                                      color: Colors.grey.shade300,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    width: 250,
                                    height: 250,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    const Divider(thickness: 1), // เส้นแบ่ง

                    // ส่วนแสดงข้อมูลสินค้า (ข้อความ, ราคา, วันที่โพสต์)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['text'] ?? 'No product description',
                            style: const TextStyle(
                              fontFamily: 'IBM Plex Sans Thai',
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Price: \$${product['price']}',
                            style: const TextStyle(
                              fontFamily: 'IBM Plex Sans Thai',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (createdAt != null)
                            Text(
                              'Posted on: ${createdAt.day}/${createdAt.month}/${createdAt.year}',
                              style: const TextStyle(
                                fontFamily: 'IBM Plex Sans Thai',
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const Divider(thickness: 1), // เส้นแบ่ง

                    // ปุ่มโต้ตอบ (ไลค์, คอมเมนต์, แชร์, บันทึก)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.favorite_border),
                                onPressed: () {
                                  // เพิ่มฟังก์ชันกดไลค์
                                },
                              ),
                              const Text('Like'),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.comment),
                                onPressed: () {
                                  // เพิ่มฟังก์ชันแสดงความคิดเห็น
                                },
                              ),
                              const Text('Comment'),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.bar_chart),
                                onPressed: () {
                                  // แสดงจำนวนการดู
                                },
                              ),
                              Text(product['views'].toString()),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.bookmark_border),
                                onPressed: () {
                                  // เพิ่มฟังก์ชันบันทึก
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.share),
                                onPressed: () {
                                  // เพิ่มฟังก์ชันแชร์
                                },
                              ),
                              const Text('Share'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
