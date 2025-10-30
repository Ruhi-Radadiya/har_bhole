import 'dart:convert';

import 'package:get/get.dart';
import 'package:har_bhole/model/customer_detail_model/customer_detail_model.dart';
import 'package:http/http.dart' as http;

class CustomerDetailController extends GetxController {
  static CustomerDetailController get instance => Get.find();

  var isLoading = false.obs;
  var customerList = <CustomerDetailModel>[].obs;
  var filterCustomer = <CustomerDetailModel>[].obs;
  var errorMessage = ''.obs;

  // ---------------- Fetch customers ----------------
  Future<void> fetchCustomers() async {
    try {
      isLoading(true);
      errorMessage('');

      final response = await http.get(
        Uri.parse(
          'https://harbhole.eihlims.com/Api/view_customer_details_api.php?action=list',
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true && data['items'] != null) {
          final List items = data['items'];
          customerList.value = items
              .map((e) => CustomerDetailModel.fromJson(e))
              .toList();
          filterCustomer.assignAll(customerList);
        } else {
          errorMessage('No customers found');
        }
      } else {
        errorMessage('Server error: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage('Error fetching customers: $e');
    } finally {
      isLoading(false);
    }
  }

  // ---------------- Search customers ----------------
  void searchCustomer(String query) {
    if (query.isEmpty) {
      filterCustomer.assignAll(customerList);
    } else {
      filterCustomer.assignAll(
        customerList.where((cust) {
          final name = cust.name.toLowerCase();
          final mobile = cust.mobile.toLowerCase();
          return name.contains(query.toLowerCase()) ||
              mobile.contains(query.toLowerCase());
        }).toList(),
      );
    }
  }

  @override
  void onInit() {
    fetchCustomers();
    super.onInit();
  }
}
