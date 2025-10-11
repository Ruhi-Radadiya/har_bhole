import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/cashbook_model/cashbook_model.dart';

class CashbookController extends GetxController {
  var entries = <CashbookEntry>[].obs;

  Future<void> fetchCashbookEntries() async {
    final response = await http.get(
      Uri.parse(
        'https://harbhole.eihlims.com/Api/cashbook_entries_api.php?action=list',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final items = data['items'] as List;
      entries.value = items.map((e) => CashbookEntry.fromJson(e)).toList();
    } else {
      Get.snackbar('Error', 'Failed to load cashbook entries');
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchCashbookEntries();
  }
}
