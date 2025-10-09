import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  // Observables
  RxList<Product> productList = <Product>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  // API URL
  final String apiUrl =
      'https://harbhole.eihlims.com/Api/product_api.php?action=list';

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await http.get(Uri.parse(apiUrl));

      // Check if response is empty
      if (response.body.isEmpty) {
        errorMessage.value = 'Empty response from server';
        print('Empty response from API');
        return;
      }

      // Try parsing JSON
      Map<String, dynamic> jsonResponse;
      try {
        jsonResponse = jsonDecode(response.body);
      } catch (jsonError) {
        errorMessage.value = 'Invalid JSON: $jsonError';
        print('Invalid JSON: ${response.body}');
        return;
      }

      // Check HTTP status code
      if (response.statusCode == 200) {
        if (jsonResponse['success'] == true && jsonResponse['items'] != null) {
          final List<dynamic> items = jsonResponse['items'];
          productList.value = items.map((e) => Product.fromJson(e)).toList();
        } else {
          errorMessage.value = jsonResponse['message'] ?? 'No products found';
          print('No products found or success=false');
        }
      } else {
        errorMessage.value = 'Failed to load products: ${response.statusCode}';
        print('Failed to load products: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
