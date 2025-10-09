import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/b2b_order/b2b_order_model.dart';
import '../../view/screens/b2b/b2b_order/order_detail_screen.dart';

class B2BOrderController extends GetxController {
  static B2BOrderController get instance => Get.find();

  var orders = <B2BOrder>[].obs;
  var filteredOrders = <B2BOrder>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    isLoading(true);
    try {
      final response = await http.get(
        Uri.parse(
          'https://harbhole.eihlims.com/Api/b2b_orders_api.php?action=list',
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Adjust according to your API response structure
        final items = data['items'] as List;
        orders.value = items.map((e) => B2BOrder.fromJson(e)).toList();
        filteredOrders.value = orders;
      } else {
        Get.snackbar("Error", "Failed to fetch orders");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  void searchOrder(String query) {
    if (query.isEmpty) {
      filteredOrders.value = orders;
    } else {
      filteredOrders.value = orders
          .where(
            (o) => o.customerName.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
  }

  void openOrderDetail(B2BOrder order) {
    Get.to(() => OrderDetailScreen(order: order));
  }
}
