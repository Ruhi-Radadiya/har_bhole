import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/order_analytics_model/order_analytics_model.dart';

class OrderAnalyticsController extends GetxController {
  static OrderAnalyticsController get instance => Get.find();

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  RxList<OrderAnalyticsModel> orderList = <OrderAnalyticsModel>[].obs;
  RxList<OrderAnalyticsModel> filterOrders = <OrderAnalyticsModel>[].obs;

  Future<void> fetchOrderAnalytics() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await http.get(
        Uri.parse(
          'http://192.168.0.118/har_bhole_farsan/Api/view_order_api.php',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['items'] != null) {
          orderList.value = List<OrderAnalyticsModel>.from(
            data['items'].map((item) => OrderAnalyticsModel.fromJson(item)),
          );
          filterOrders.assignAll(orderList);
        } else {
          errorMessage.value = "No materials found.";
        }
      } else {
        errorMessage.value = "Failed to load materials.";
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void searchMaterial(String query) {
    if (query.isEmpty) {
      filterOrders.assignAll(orderList);
    } else {
      filterOrders.assignAll(
        orderList.where(
          (item) =>
              (item.customerName).toLowerCase().contains(query.toLowerCase()) ||
              (item.customerName).toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
  }

  @override
  void onInit() {
    fetchOrderAnalytics();
    ever(orderList, (_) {
      filterOrders.assignAll(orderList);
    });
    super.onInit();
  }
}
