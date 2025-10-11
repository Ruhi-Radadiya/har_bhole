import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/finished_goods_stock/finished_goods_stock_model.dart';

class FinishedGoodsStockController extends GetxController {
  static FinishedGoodsStockController get instance => Get.find();

  var isLoading = false.obs;
  var finishedGoodsList = <FinishedGoodsStockModel>[].obs;

  final String apiUrl =
      "https://harbhole.eihlims.com/Api/finished_goods_stock_api.php?action=list";

  Future<void> fetchFinishedGoodsStock() async {
    try {
      isLoading(true);
      finishedGoodsList.clear();

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data["success"] == true && data["items"] != null) {
          finishedGoodsList.value = List<FinishedGoodsStockModel>.from(
            data["items"].map((x) => FinishedGoodsStockModel.fromJson(x)),
          );
        } else {
          Get.snackbar("No Data", "No finished goods found");
          log("No finished goods found ");
        }
      } else {
        Get.snackbar("Error", "Failed to fetch data (${response.statusCode})");
        log("Failed to fetch data (${response.statusCode})");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
      log("Something went wrong: $e");
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchFinishedGoodsStock();
  }
}
