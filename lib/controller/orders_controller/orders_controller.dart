import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/orders_model/orders_model.dart';

class AllOrdersController extends GetxController {
  static AllOrdersController get instance => Get.find();

  RxList<Order> allOrders = <Order>[].obs; // all data from API
  RxList<Order> paginatedOrders = <Order>[].obs; // current page data
  RxBool isLoading = false.obs;
  RxInt page = 1.obs;
  RxInt totalPages = 1.obs;
  int perPage = 3;
  RxString searchQuery = ''.obs;

  final String apiUrl =
      'https://harbhole.eihlims.com/Api/view_order_api.php?action=list';

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  /// Fetch all orders from API
  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;

      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true && data['items'] != null) {
          final items = List<Map<String, dynamic>>.from(data['items']);
          allOrders.value = items.map((e) => Order.fromJson(e)).toList();

          perPage = data['per_page'] ?? 3;

          final totalItems = data['total'] ?? allOrders.length;
          totalPages.value = (totalItems / perPage).ceil();

          // Load first page
          updatePagination(page: 1);
        } else {
          print('Error fetching orders: ${data['message']}');
        }
      } else {
        print('Failed to fetch orders: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching orders: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Public method to update current page
  void updatePagination({required int page}) {
    this.page.value = page;
    int start = (page - 1) * perPage;
    int end = start + perPage;
    if (end > allOrders.length) end = allOrders.length;
    paginatedOrders.value = allOrders.sublist(start, end);
  }

  void nextPage() {
    if (page.value < totalPages.value) {
      updatePagination(page: page.value + 1);
    }
  }

  void prevPage() {
    if (page.value > 1) {
      updatePagination(page: page.value - 1);
    }
  }

  /// Search in all orders
  void searchOrders(String query) {
    searchQuery.value = query.trim().toLowerCase();

    if (searchQuery.value.isEmpty) {
      // If search is cleared, show the first page of all orders
      updatePagination(page: 1);
      return;
    }

    final filtered = allOrders.where((order) {
      final name = order.customerName.trim().toLowerCase();
      return name.contains(searchQuery.value);
    }).toList();

    if (filtered.isEmpty) {
      paginatedOrders.clear();
    } else {
      totalPages.value = (filtered.length / perPage).ceil();
      paginatedOrders.value = filtered.take(perPage).toList();
    }
  }
}
