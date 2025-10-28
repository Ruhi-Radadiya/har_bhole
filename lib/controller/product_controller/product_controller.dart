import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/product_model/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  RxList<Product> productList = <Product>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxList<Product> filteredProducts = <Product>[].obs;

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

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          errorMessage.value = 'Empty response from server';
          return;
        }

        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        if (jsonResponse['success'] == true && jsonResponse['items'] != null) {
          final List<dynamic> items = jsonResponse['items'];
          final allProducts = items
              .map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList();

          productList.value = allProducts;
          filteredProducts.value = List<Product>.from(productList);
        } else {
          errorMessage.value = jsonResponse['message'] ?? 'No products found';
        }
      } else {
        errorMessage.value = 'Failed to load products: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
      print('Error fetching products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Map<String, List<Product>> get groupedProducts {
    final Map<String, List<Product>> grouped = {};
    for (var product in filteredProducts) {
      final category = product.categoryName ?? 'Uncategorized';
      grouped.putIfAbsent(category, () => []).add(product);
    }
    return grouped;
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      filteredProducts.value = productList;
    } else {
      final lowerQuery = query.toLowerCase().trim();
      filteredProducts.value = productList.where((p) {
        final words = p.productName.toLowerCase().split(' ');
        return words.any((word) => word.startsWith(lowerQuery));
      }).toList();
    }
  }
}
