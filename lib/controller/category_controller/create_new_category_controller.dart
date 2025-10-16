import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/home_page_models/premium_collection_model.dart';

class CreateCategoryController extends GetxController {
  static CreateCategoryController get instance => Get.find();

  RxBool isLoading = false.obs;

  final String createUrl =
      "https://harbhole.eihlims.com/Api/category_api.php?action=add";
  final String updateUrl =
      "https://harbhole.eihlims.com/Api/category_api.php?action=edit";

  // Create
  Future<bool> createCategory(PremiumCollectionModel category) async {
    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse(createUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "category_id": category.categoryId,
          "category_name": category.categoryName,
          "category_code": category.categoryCode,
          "description": category.description,
          "parent_id": category.parentId,
          "status": category.status, // pass string
          "sort_order": category.sortOrder,
          "show_on_home": category.showOnHome, // pass string
          "category_image": category.categoryImage,
        }),
      );
      isLoading.value = false;

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        return res['success'] == true;
      }
      return false;
    } catch (e) {
      isLoading.value = false;
      print("Error creating category: $e");
      return false;
    }
  }

  // Update
  Future<bool> updateCategory(PremiumCollectionModel category) async {
    isLoading.value = true;

    final body = {
      "category_id": category.categoryId,
      "category_name": category.categoryName,
      "category_code": category.categoryCode,
      "description": category.description,
      "parent_id": category.parentId ?? "",
      "status": int.tryParse(category.status) ?? 1,
      "sort_order": int.tryParse(category.sortOrder) ?? 1,
      "show_on_home": int.tryParse(category.showOnHome) ?? 1,
      "category_image": category.categoryImage,
    };

    try {
      final response = await http.post(
        Uri.parse(
          "https://harbhole.eihlims.com/Api/category_api.php?action=edit",
        ),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        Fluttertoast.showToast(
          msg: "Category updated successfully!",
          backgroundColor: Colors.green.shade300,
          textColor: Colors.white,
        );
        log("Category updated successfully!");
        return true;
      } else {
        Fluttertoast.showToast(
          msg: data['message'] ?? "Failed to update category",
          backgroundColor: Colors.red.shade300,
          textColor: Colors.white,
        );
        log("Failed to update category: ${data['message']}");
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong: $e",
        backgroundColor: Colors.red.shade300,
        textColor: Colors.white,
      );
      log("Error updating category: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
