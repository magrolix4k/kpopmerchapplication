// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kpopmerchapplication/models/product_model.dart';
// import 'package:kpopmerchapplication/models/store_model.dart';
// import 'package:kpopmerchapplication/presentation/controllers/auth_controller.dart';
// import 'package:kpopmerchapplication/services/user_service/users_service.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ProductDetailScreen extends StatefulWidget {
//   final String? textId;
//   const ProductDetailScreen({super.key, this.textId});

//   @override
//   State<ProductDetailScreen> createState() => _ProductDetailScreenState();
// }

// class _ProductDetailScreenState extends State<ProductDetailScreen> {
//   final AuthController authController = Get.find<AuthController>();
//   final UserApiService apiService = UserApiService();
//   final PageController _pageController =
//       PageController(); // PageController สำหรับ PageView

//   late Timer _timer;
//   bool isLiked = false;
//   ProductModel? _productData;
//   StoreModel? _storeData;

//   @override
//   void initState() {
//     super.initState();
//     _fetchProductData();

//     _timer = Timer.periodic(const Duration(seconds: 60), (Timer t) {
//       _fetchProductData();
//     });
//   }

//   // ฟังก์ชันดึงข้อมูลผู้ใช้จาก API
//   void _fetchProductData() async {
//     if (widget.textId != null) {
//       try {
//         print("fetching store ${widget.textId}");
//         ProductModel? productModel =
//             await apiService.getProductItem(widget.textId!);
//         StoreModel? storeModel =
//             await apiService.getProductStore(productModel!.sid);
//         setState(() {
//           _productData = productModel;
//           _storeData = storeModel;
//         });
//       } catch (e) {
//         print('Error fetching store data: $e');
//       }
//     } else {
//       print('Error: textId is null');
//     }
//   }

//   void _launchTwitterUrl(String twitterUrl) async {
//     final Uri url = Uri.parse(twitterUrl);

//     if (await canLaunchUrl(url)) {
//       await launchUrl(url,
//           mode: LaunchMode
//               .externalApplication); // เปิดลิงก์ในแอพ Twitter หรือเบราว์เซอร์
//     } else {
//       throw 'Could not launch $twitterUrl';
//     }
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 priceFavoriteAndBackButton(size, context),
//                 const SizedBox(height: 20),
//                 _productData != null
//                     ? Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 15),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text.rich(
//                               TextSpan(
//                                 children: [
//                                   TextSpan(
//                                     text: "${_productData!.price}",
//                                     style: const TextStyle(
//                                       fontSize: 30,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                   const TextSpan(
//                                     text: " ฿",
//                                     style: TextStyle(
//                                       fontSize: 30,
//                                       fontWeight: FontWeight.normal,
//                                       color: Colors.black87,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Row(
//                               children: [
//                                 const Text(
//                                   'createdAt',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.black54,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 5),
//                                 Text(
//                                   '${_productData!.createdAt}',
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 15),
//                             Row(
//                               mainAxisSize: MainAxisSize.max,
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Expanded(
//                                   flex: 2,
//                                   child: houseInfo(
//                                       Icons.tag, _productData!.tags![0]),
//                                 ),
//                                 const SizedBox(width: 10),
//                                 Expanded(
//                                   flex: 2,
//                                   child: houseInfo(Icons.group_outlined,
//                                       _productData!.groupName),
//                                 ),
//                               ],
//                             ),
//                             const Divider(),
//                             Column(
//                               children: [
//                                 ListTile(
//                                   onTap: () {
//                                     Get.toNamed(
//                                         '/storeprofile?sid=${_storeData!.ownerId}');
//                                   },
//                                   contentPadding: EdgeInsets.zero,
//                                   leading: CircleAvatar(
//                                     radius: 25,
//                                     backgroundImage: NetworkImage(
//                                       '${_storeData!.profileImage}',
//                                     ),
//                                   ),
//                                   title: Text(
//                                     '${_storeData!.name}',
//                                     softWrap: true,
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: const TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w700,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   trailing: ElevatedButton(
//                                     onPressed: () {
//                                       // ฟังก์ชันเมื่อกดปุ่มติดตาม
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.yellow[500],
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(5),
//                                       ),
//                                       minimumSize: const Size(100, 35),
//                                       elevation: 0,
//                                     ),
//                                     child: const Text(
//                                       'Follow',
//                                       style: TextStyle(color: Colors.black),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const Divider(),
//                             const SizedBox(height: 10),
//                             const Text(
//                               "Details",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                             Text(
//                               _productData!.text,
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             const SizedBox(height: 100),
//                           ],
//                         ),
//                       )
//                     : const Center(child: CircularProgressIndicator()),
//               ],
//             ),
//           ),
//           // let's add some blur
//           Align(
//             alignment: FractionalOffset.bottomCenter,
//             child: Container(
//               width: size.width,
//               height: 150,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.bottomCenter,
//                   end: Alignment.topCenter,
//                   colors: [
//                     Colors.white,
//                     Colors.white.withOpacity(0.7),
//                     Colors.white.withOpacity(0.0),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(15),
//             child: Align(
//               alignment: const Alignment(0, 1),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 60,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       color: const Color(0xff266ef1),
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: const Center(
//                       child: Icon(
//                         Icons.bookmark,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   GestureDetector(
//                     onTap: () {
//                       // ลิงก์ Twitter (X) ที่ต้องการเปิด
//                       String twitterUrl = '${_productData!.url}';
//                       print(twitterUrl);
//                       _launchTwitterUrl(twitterUrl);
//                     },
//                     child: Container(
//                       width: size.width / 1.3,
//                       height: 60,
//                       decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: const Center(
//                         child: Text(
//                           "view in twitte (x)",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Container houseInfo(icon, name) {
//     return Container(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 17,
//         vertical: 10,
//       ),
//       color: Colors.black12.withOpacity(0.04),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon),
//           const SizedBox(width: 7),
//           Text(
//             name,
//             style: const TextStyle(
//               fontSize: 15,
//               color: Colors.black54,
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget priceFavoriteAndBackButton(Size size, BuildContext context) {
//     return _productData != null
//         ? Column(
//             children: [
//               SizedBox(
//                 height: size.height * 0.4,
//                 child: Stack(
//                   children: [
//                     PageView.builder(
//                       controller: _pageController,
//                       itemCount: _productData!.mediaUrls!.length,
//                       itemBuilder: (context, index) {
//                         return Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             image: DecorationImage(
//                               fit: BoxFit.cover,
//                               image: NetworkImage(
//                                 _productData!.mediaUrls![index],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
// // ปุ่มย้อนกลับ
//                     Positioned(
//                       top: 20,
//                       left: 20,
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: Container(
//                           width: 45,
//                           height: 45,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: Colors.white, width: 1.5),
//                           ),
//                           child: const Center(
//                             child: Icon(
//                               Icons.arrow_back,
//                               size: 30,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),

//                     // ปุ่ม favorite
//                     Positioned(
//                       top: 20,
//                       right: 20,
//                       child: InkWell(
//                         onTap: () {
//                           setState(() {
//                             isLiked = !isLiked;
//                           });
//                         },
//                         child: Container(
//                           width: 45,
//                           height: 45,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: Colors.white, width: 1.5),
//                           ),
//                           child: Center(
//                             child: Icon(
//                               isLiked == false
//                                   ? Icons.favorite_border
//                                   : Icons.favorite,
//                               size: 30,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // SmoothPageIndicator
//               const SizedBox(height: 10),
//               SmoothPageIndicator(
//                 controller: _pageController,
//                 count: _productData!.mediaUrls!.length,
//                 effect: const WormEffect(
//                   dotHeight: 8,
//                   dotWidth: 8,
//                   activeDotColor: Colors.black,
//                   dotColor: Colors.grey,
//                 ),
//               ),
//             ],
//           )
//         : const CircularProgressIndicator();
//   }
// }
