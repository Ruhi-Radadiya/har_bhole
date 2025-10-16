import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DeleteCategoryController extends GetxController {
  static DeleteCategoryController get instance => Get.find();

  Future<bool> deleteCategory(String categoryId) async {
    try {
      final uri = Uri.parse(
        "https://harbhole.eihlims.com/Api/category_api.php?action=delete",
      );

      // Send category_id as form data
      final response = await http.post(uri, body: {'category_id': categoryId});

      print("🔁 Delete Category Response: ${response.body}");

      final res = response.body;

      if (res.contains('"success":true')) {
        // Show toast on success
        Fluttertoast.showToast(
          msg: "Category deleted successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xff4CAF50), // green
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return true;
      } else {
        // Show toast on failure
        Fluttertoast.showToast(
          msg: "Failed to delete category",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xffF44336), // red
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xffF44336), // red
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
  }
}
