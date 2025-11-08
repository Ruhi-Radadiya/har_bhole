import 'dart:convert';
import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/stock_movement_model/stock_movement_model.dart';

class StockMovementController extends GetxController {
  static StockMovementController get instance => Get.find();

  var isLoading = false.obs;
  var materials = <StockMovementModel>[].obs;
  var filteredMaterials = <StockMovementModel>[].obs;
  var errorMessage = ''.obs;

  final String apiUrl = "https://harbhole.eihlims.com/Api/stock_movements.php";

  @override
  void onInit() {
    super.onInit();
    fetchStockMovements();
  }

  /// ✅ Fetch Stock Movements
  Future<void> fetchStockMovements() async {
    try {
      isLoading(true);
      errorMessage('');

      final response = await http.get(Uri.parse(apiUrl));
      log("📦 Stock Movement GET Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["success"] == true &&
            data["data"] != null &&
            (data["data"] as List).isNotEmpty) {
          materials.value = List<StockMovementModel>.from(
            data["data"].map((x) => StockMovementModel.fromJson(x)),
          );
          filteredMaterials.assignAll(materials);
          log("✅ Stock movements fetched: ${materials.length}");
        } else {
          materials.clear();
          filteredMaterials.clear();
          errorMessage("No stock movement data found.");
          log("⚠️ No stock movement data found.");
        }
      } else {
        errorMessage("Server error: ${response.statusCode}");
        Get.snackbar("Error", "Server error: ${response.statusCode}");
      }
    } catch (e) {
      materials.clear();
      filteredMaterials.clear();
      errorMessage("Failed to fetch stock movements.");
      log("❌ Error fetching stock movements: $e");
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteStockMovement(String movementId) async {
    try {
      isLoading.value = true;

      final url = Uri.parse(
        "https://harbhole.eihlims.com/Api/stock_movements.php?action=delete",
      );

      final response = await http.post(url, body: {'movement_id': movementId});

      log('🟠 Delete Stock Movement Response: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['success'] == true) {
          Fluttertoast.showToast(msg: "Stock movement deleted successfully");

          // 🟢 Remove deleted movement from list (reactive update)
          materials.removeWhere((item) => item.movementId == movementId);

          // Optionally fetch updated data
          // await fetchStockMovements();

          Get.back(); // close detail screen
        } else {
          Fluttertoast.showToast(
            msg: "Failed: ${jsonResponse['message'] ?? 'Unknown error'}",
          );
        }
      } else {
        log("❌ Server error: ${response.statusCode}");
        Fluttertoast.showToast(msg: "Server error: ${response.statusCode}");
      }
    } catch (e) {
      log("❌ Error deleting stock movement: $e");
      Fluttertoast.showToast(msg: "Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// 🔍 Search Functionality
  void searchMaterial(String query) {
    if (query.isEmpty) {
      filteredMaterials.assignAll(materials);
    } else {
      filteredMaterials.assignAll(
        materials.where((item) {
          final name = item.referenceType.toLowerCase();
          final note = item.notes.toLowerCase();
          return name.contains(query.toLowerCase()) ||
              note.contains(query.toLowerCase());
        }).toList(),
      );
    }
  }
}
