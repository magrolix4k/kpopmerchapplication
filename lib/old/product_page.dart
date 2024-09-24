// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'api_service.dart';

// class ProductPage extends StatefulWidget {
//   const ProductPage({super.key});

//   @override
//   _ProductPageState createState() => _ProductPageState();
// }

// class _ProductPageState extends State<ProductPage> {
//   final ApiService apiService = ApiService();
//   List<dynamic> products = []; // เก็บรายการสินค้าทั้งหมด

//   Timer? _timer; // สำหรับตั้งเวลาในการดึงข้อมูลซ้ำ

//   @override
//   void initState() {
//     super.initState();
//     _fetchAllProducts(); // เรียกฟังก์ชันดึงสินค้าทั้งหมดเมื่อโหลดหน้า
//     _startPolling(); // เริ่มการ Polling
//   }

//   @override
//   void dispose() {
//     _timer?.cancel(); // หยุด Timer เมื่อปิดหน้า
//     super.dispose();
//   }

//   // ฟังก์ชันดึงข้อมูลสินค้าทั้งหมด
//   Future<void> _fetchAllProducts() async {
//     try {
//       final data = await apiService.getAllProducts();
//       setState(() {
//         products = data; // เก็บข้อมูลสินค้าในตัวแปร state
//       });
//     } catch (e) {
//       print('Error fetching all products: $e');
//     }
//   }

//   // ฟังก์ชันสำหรับการ Polling
//   void _startPolling() {
//     _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
//       _fetchAllProducts(); // ดึงข้อมูลใหม่ทุกๆ 10 วินาที
//     });
//   }

//   // ฟังก์ชันอัปเดตข้อมูลสินค้า
//   Future<void> _updateProduct(String productId) async {
//     try {
//       // ตัวอย่างข้อมูลที่จะแก้ไข
//       final updatedData = {
//         'price': 999.99,
//         'views': 50,
//       };
//       await apiService.updateProduct(productId, updatedData);
//       _fetchAllProducts(); // รีเฟรชข้อมูลหลังอัปเดต
//     } catch (e) {
//       print('Error updating product: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Products')),
//       body: products.isNotEmpty
//           ? ListView.builder(
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 final product = products[index];
//                 return ListTile(
//                   title: Text(product['name']),
//                   subtitle: Column(
//                     children: [
//                       Text(product['text']),
//                       Image.network(product['media_urls'][0]),
//                       SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Price: ${product['price']}'),
//                           Text('Views: ${product['views'].toString()}'),
//                         ],
//                       ),
//                     ],
//                   ),
//                   // trailing: IconButton(
//                   //   icon: const Icon(Icons.edit),
//                   //   onPressed: () {
//                   //     // อัปเดตข้อมูลสินค้าตัวนี้
//                   //     _updateProduct(product['product_id'].toString());
//                   //   },
//                   // ),
//                 );
//               },
//             )
//           : const Center(
//               child:
//                   CircularProgressIndicator()), // แสดง loading ระหว่างดึงข้อมูล
//     );
//   }
// }
