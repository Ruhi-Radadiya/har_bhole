import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/home_page_models/premium_collection_model.dart';

class CreateCategoryController extends GetxController {
  static CreateCategoryController get instance => Get.find();

  RxBool isLoading = false.obs;
  RxString nextCategoryCode = "CAT0001".obs;

  final String apiUrl =
      "https://harbhole.eihlims.com/Api/category_api.php?action=add";

  Future<bool> createCategory(PremiumCollectionModel category) async {
    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "category_name": category.categoryName,
          "category_code": category.categoryCode,
          "description": category.description,
          "parent_id": category.parentId,
          "status": int.tryParse(category.status) ?? 1,
          "sort_order": int.tryParse(category.sortOrder) ?? 1,
          "show_on_home": int.tryParse(category.showOnHome) ?? 1,
          "category_image": category.categoryImage,
        }),
      );

      isLoading.value = false;

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        return res['success'] == true;
      } else {
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      print("Error creating category: $e");
      return false;
    }
  }

  // Future<void> fetchNextCategoryCode() async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse(
  //         'https://harbhole.eihlims.com/Api/category_api.php?action=list',
  //       ),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       final items = data['items'] as List<dynamic>;
  //
  //       // Filter only codes that start with 'CAT'
  //       final catCodes = items
  //           .map((e) => e['category_code'].toString())
  //           .where((code) => code.startsWith('CAT'))
  //           .toList();
  //
  //       if (catCodes.isEmpty) {
  //         nextCategoryCode.value = "CAT0001";
  //         return;
  //       }
  //
  //       // Extract numeric part safely
  //       final numbers = <int>[];
  //       for (var code in catCodes) {
  //         try {
  //           final numericPart = code.replaceAll(
  //             RegExp(r'[^0-9]'),
  //             '',
  //           ); // Remove all non-numbers
  //           if (numericPart.isNotEmpty) {
  //             numbers.add(int.parse(numericPart));
  //           }
  //         } catch (_) {}
  //       }
  //
  //       final maxNum = numbers.isNotEmpty
  //           ? numbers.reduce((a, b) => a > b ? a : b)
  //           : 0;
  //       nextCategoryCode.value =
  //           'CAT${(maxNum + 1).toString().padLeft(4, '0')}';
  //     } else {
  //       nextCategoryCode.value = "CAT0001";
  //     }
  //   } catch (e) {
  //     nextCategoryCode.value = "CAT0001";
  //     print("Error fetching next category code: $e");
  //   }
  // }
}
