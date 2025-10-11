import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/raw_material_model/raw_material_model.dart';

class RawMaterialController extends GetxController {
  static RawMaterialController get instance => Get.find();

  RxBool isLoading = false.obs;
  RxList<RawMaterialModel> materialList = <RawMaterialModel>[].obs;

  Future<void> fetchRawMaterials() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(
          'https://harbhole.eihlims.com/Api/raw_material_api.php?action=list',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['items'] != null) {
          materialList.value = List<RawMaterialModel>.from(
            data['items'].map((item) => RawMaterialModel.fromJson(item)),
          );
        }
      } else {
        Get.snackbar('Error', 'Failed to load materials');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    fetchRawMaterials();
    super.onInit();
  }
}
