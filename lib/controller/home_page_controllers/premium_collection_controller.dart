import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/home_page_models/premium_collection_model.dart';

class PremiumCollectionController extends GetxController {
  var premiumCollection = <PremiumCollectionModel>[].obs;
  var isLoading = false.obs;

  final String baseUrl =
      'http://192.168.0.118/har_bhole_farsan/Api/category_api.php?action=list';

  @override
  void onInit() {
    super.onInit();
    fetchPremiumCollection();
  }

  Future<void> fetchPremiumCollection() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(baseUrl)); // replace endpoint
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List items = data['items'];
        premiumCollection.value = items
            .map((e) => PremiumCollectionModel.fromJson(e))
            .toList();
      } else {
        Get.snackbar('Error', 'Failed to fetch categories');
        log("Error********** :  ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      log("Error********** : $e");
    } finally {
      isLoading.value = false;
    }
  }
}
