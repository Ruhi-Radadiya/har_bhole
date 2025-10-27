import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/stock_movement_model/stock_movement_model.dart';

class StockMovementController extends GetxController {
  var isLoading = false.obs;
  var stockMovementList = <StockMovementModel>[].obs;

  final String apiUrl =
      "http://192.168.0.118/har_bhole_farsan/Api/stock_movements.php";

  Future<void> fetchStockMovements() async {
    try {
      isLoading.value = true;

      final response = await http.get(Uri.parse(apiUrl));
      log("📦 Stock Movement GET Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["success"] == true &&
            data["data"] != null &&
            (data["data"] as List).isNotEmpty) {
          stockMovementList.value = List<StockMovementModel>.from(
            data["data"].map((x) => StockMovementModel.fromJson(x)),
          );
        } else {
          stockMovementList.clear(); // 🧹 Clear old data
          log("⚠️ No stock movement data found.");
        }
      } else {
        stockMovementList.clear();
        Get.snackbar("Error", "Server error: ${response.statusCode}");
      }
    } catch (e) {
      stockMovementList.clear();
      log("❌ Error fetching stock movements: $e");
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
