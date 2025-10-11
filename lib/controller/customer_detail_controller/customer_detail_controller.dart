import 'dart:convert';

import 'package:get/get.dart';
import 'package:har_bhole/model/customer_detail_model/customer_detail_model.dart';
import 'package:http/http.dart' as http;

class CustomerDetailController extends GetxController {
  static CustomerDetailController get instance => Get.find();

  var isLoading = false.obs;
  var customerList = <CustomerDetailModel>[].obs;

  Future<void> fetchCustomers() async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse(
          'https://harbhole.eihlims.com/Api/view_customer_details_api.php?action=list',
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final List items = data['items'] ?? [];
          customerList.value = items
              .map((e) => CustomerDetailModel.fromJson(e))
              .toList();
        }
      }
    } catch (e) {
      print('Error fetching customers: $e');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    fetchCustomers();
    super.onInit();
  }
}
