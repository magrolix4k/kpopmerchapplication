import 'package:dio/dio.dart';

class ProductApiService {
  final Dio dio = Dio();
  final String baseUrl = 'https://getproductswithstore-h3js32dvhq-uc.a.run.app';

  Future<List<dynamic>> getProductsWithStore() async {
    try {
      final response = await dio.get(baseUrl);
      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw Exception('Failed to load products with store');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }
}
