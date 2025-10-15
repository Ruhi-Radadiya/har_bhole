import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DeleteB2BOrderController extends GetxController {
  static DeleteB2BOrderController get instance => Get.find();

  Future<bool> deleteOrder(String orderId) async {
    try {
      final uri = Uri.parse(
        "https://harbhole.eihlims.com/Api/b2b_orders_api.php?action=delete",
      );

      final response = await http.post(
        uri,
        body: {'id': orderId}, // ✅ API expects 'id'
      );

      print("🔁 Delete B2B Order Response: ${response.body}");

      if (response.body.contains('"success":true')) {
        Fluttertoast.showToast(
          msg: "Order deleted successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xff4CAF50),
          textColor: Colors.white,
        );
        return true;
      } else {
        Fluttertoast.showToast(
          msg: "Failed to delete order",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xffF44336),
          textColor: Colors.white,
        );
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xffF44336),
        textColor: Colors.white,
      );
      return false;
    }
  }
}
