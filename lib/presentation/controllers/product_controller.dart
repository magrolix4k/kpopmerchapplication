import 'package:get/get.dart';
import 'dart:async';
import 'package:kpopmerchapplication/services/product_service/product_service.dart';

class ProductController extends GetxController {
  final ProductApiService _apiService = ProductApiService();
  RxList<dynamic> products = <dynamic>[].obs;
  late Timer _timer;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();

    _timer = Timer.periodic(const Duration(seconds: 60), (Timer t) {
      fetchProducts();
    });
  }

  // ฟังก์ชันดึงข้อมูลสินค้าพร้อมข้อมูลร้านค้าจาก API
  void fetchProducts() async {
    try {
      var response = await _apiService.getProductsWithStore();
      products.value = response; // เก็บข้อมูลสินค้าและร้านค้าใน RxList
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
