import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CashEntryController extends GetxController {
  var categories = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var responseMessage = "".obs;

  // Fetch categories from API
  Future<void> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://harbhole.eihlims.com/Api/cashbook_entries_api.php?action=list',
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        categories.value = data
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
      } else {
        print('Failed to load categories. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  // Add cash entry API
  Future<void> addCashEntry({
    required String entryDate,
    required String entryType,
    required String amount,
    required int categoryId,
    required String paymentMethod,
    String? referenceNo,
    String? description,
    String? attachment,
    required int createdBy,
  }) async {
    try {
      isLoading.value = true;

      final Map<String, dynamic> data = {
        "entry_date": entryDate,
        "entry_type": entryType,
        "amount": double.tryParse(amount) ?? 0,
        "category_id": categoryId,
        "payment_method": paymentMethod,
        "reference_no": referenceNo ?? "",
        "description": description ?? "",
        "attachment": attachment ?? "",
        "created_by": createdBy,
      };

      final response = await http.post(
        Uri.parse(
          'https://harbhole.eihlims.com/Api/cashbook_entries_api.php?action=add',
        ),
        headers: {"Content-Type": "application/json"},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        responseMessage.value = body['message'] ?? "Entry Added";
      } else {
        responseMessage.value =
            "Failed to add entry. Status: ${response.statusCode}";
      }
    } catch (e) {
      responseMessage.value = "Error: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
