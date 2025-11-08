import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/all_orders_model/all_orders_model.dart';

class AllOrdersController extends GetxController {
  static AllOrdersController get instance => Get.find();

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  RxList<AllOrdersModel> allOrderList = <AllOrdersModel>[].obs;
  RxList<AllOrdersModel> filterAllOrders = <AllOrdersModel>[].obs;

  Future<void> fetchAllOrderAnalytics() async {
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
          allOrderList.value = List<AllOrdersModel>.from(
            data['items'].map((item) => AllOrdersModel.fromJson(item)),
          );
          filterAllOrders.assignAll(allOrderList);
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
      filterAllOrders.assignAll(allOrderList);
    } else {
      filterAllOrders.assignAll(
        allOrderList.where(
          (item) =>
              (item.customerName).toLowerCase().contains(query.toLowerCase()) ||
              (item.customerName).toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
  }

  @override
  void onInit() {
    fetchAllOrderAnalytics();
    ever(allOrderList, (_) {
      filterAllOrders.assignAll(allOrderList);
    });
    super.onInit();
  }
}
