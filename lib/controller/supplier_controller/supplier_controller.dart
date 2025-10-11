import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/supplier_model/supplier_model.dart';

class SupplierController extends GetxController {
  static SupplierController get instance => Get.find();

  var suppliersList = <Supplier>[].obs;
  var isLoading = false.obs;

  Future<void> fetchSuppliers() async {
    try {
      isLoading.value = true;
      suppliersList.clear();

      final response = await http.get(
        Uri.parse(
          'https://harbhole.eihlims.com/Api/suppliers_api.php?action=list',
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final items = data['items'] as List<dynamic>;
          suppliersList.addAll(items.map((e) => Supplier.fromJson(e)));
        }
      } else {
        print("Failed to fetch suppliers. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching suppliers: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
