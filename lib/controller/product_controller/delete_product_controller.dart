import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DeleteProductController extends GetxController {
  static DeleteProductController get instance => Get.find();

  Future<bool> deleteProduct(String productId) async {
    try {
      final uri = Uri.parse(
        "https://harbhole.eihlims.com/Api/product_api.php?action=delete",
      );

      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"product_id": productId}),
      );

      print("🔁 Delete Response: ${response.body}");

      final Map<String, dynamic> res = jsonDecode(response.body);

      if (res['success'] == true) {
        Fluttertoast.showToast(
          msg: res['message'] ?? "Product deleted successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xff4CAF50), // green
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return true;
      } else {
        Fluttertoast.showToast(
          msg: res['message'] ?? "Failed to delete product",
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
