import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EditCategoryController extends GetxController {
  final isLoading = false.obs;
  final categoryId = "".obs;
  final categoryNameController = TextEditingController();
  final categoryCodeController = TextEditingController();
  final categoryDescriptionController = TextEditingController();
  final sortOrderController = TextEditingController();
  final showOnHome = false.obs;

  final String apiUrl =
      "https://harbhole.eihlims.com/Api/category_api.php?action=edit";

  void setCategoryId(String id) {
    categoryId.value = id;
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  bool validateForm() {
    if (categoryId.value.isEmpty) {
      showToast('Category ID is required');
      return false;
    }
    if (categoryNameController.text.trim().isEmpty) {
      showToast('Category name is required');
      return false;
    }
    if (categoryCodeController.text.trim().isEmpty) {
      showToast('Category code is required');
      return false;
    }
    if (sortOrderController.text.trim().isNotEmpty &&
        int.tryParse(sortOrderController.text.trim()) == null) {
      showToast('Sort order must be a number');
      return false;
    }
    return true;
  }

  Future<void> updateCategory() async {
    if (!validateForm()) return;

    try {
      isLoading.value = true;

      final Map<String, dynamic> body = {
        "category_id": int.tryParse(categoryId.value) ?? 0,
        "category_name": categoryNameController.text.trim(),
        "category_code": categoryCodeController.text.trim(),
        "description": categoryDescriptionController.text.trim(),
        "sort_order": int.tryParse(sortOrderController.text.trim()) ?? 0,
        "show_on_home": showOnHome.value ? 1 : 0,
      };

      log("Sending edit payload: ${jsonEncode(body)}");

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      log('Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] == true || data['status'] == 'success') {
          showToast('✅ Category updated successfully!');
          Get.back();
        } else {
          final message =
              data['message'] ?? data['error'] ?? 'Failed to update category';
          showToast('❌ $message');
          log('API error: $message');
        }
      } else {
        showToast('❌ Failed to update category (${response.statusCode})');
      }
    } catch (e, st) {
      log('Exception updating category: $e\n$st');
      showToast('⚠️ Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void preloadFrom(dynamic category) {
    try {
      categoryId.value =
          (category?.categoryId ??
                  category?['category_id'] ??
                  category?['categoryId'] ??
                  '')
              .toString();
    } catch (_) {
      categoryId.value = '';
    }
    try {
      categoryNameController.text =
          (category?.categoryName ??
                  category?['category_name'] ??
                  category?['name'] ??
                  '')
              .toString();
    } catch (_) {
      categoryNameController.text = '';
    }
    try {
      categoryCodeController.text =
          (category?.categoryCode ??
                  category?['category_code'] ??
                  category?['categoryCode'] ??
                  '')
              .toString();
    } catch (_) {
      categoryCodeController.text = '';
    }
    try {
      categoryDescriptionController.text =
          (category?.description ??
                  category?['description'] ??
                  category?['category_description'] ??
                  '')
              .toString();
    } catch (_) {
      categoryDescriptionController.text = '';
    }
    try {
      final s =
          (category?.sortOrder ??
                  category?['sort_order'] ??
                  category?['sortOrder'] ??
                  '')
              .toString();
      sortOrderController.text = s.isEmpty
          ? ''
          : int.tryParse(s)?.toString() ?? '';
    } catch (_) {
      sortOrderController.text = '';
    }
    try {
      final showVal =
          (category?.showOnHome ??
          category?['show_on_home'] ??
          category?['showOnHome']);
      if (showVal is int) {
        showOnHome.value = showVal == 1;
      } else if (showVal is String) {
        showOnHome.value = showVal == '1' || showVal.toLowerCase() == 'true';
      } else if (showVal is bool) {
        showOnHome.value = showVal;
      } else {
        showOnHome.value = false;
      }
    } catch (_) {
      showOnHome.value = false;
    }
  }

  void clearForm() {
    categoryId.value = "";
    categoryNameController.clear();
    categoryCodeController.clear();
    categoryDescriptionController.clear();
    sortOrderController.clear();
    showOnHome.value = false;
  }
}
