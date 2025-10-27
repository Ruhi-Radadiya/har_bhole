import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/banner_model/banner_model.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  var banners = <BannerModel>[].obs;
  var isLoading = false.obs;

  final String apiUrl =
      "http://192.168.0.118/har_bhole_farsan/Api/banners.php?action=list";

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }

  Future<void> fetchBanners() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["success"] == true && data["data"] != null) {
          banners.value = (data["data"] as List)
              .map((item) => BannerModel.fromJson(item))
              .toList();
        } else {
          log("⚠️ No banners found or API failed");
        }
      } else {
        log("⚠️ Failed to fetch banners: ${response.statusCode}");
      }
    } catch (e) {
      log("❌ Error fetching banners: $e");
    } finally {
      isLoading(false);
    }
  }
}
