import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/cart_model/cart_model.dart';

class OrderCartController extends GetxController {
  static OrderCartController get instance => Get.find();

  RxList<CartModel> cartItems = <CartModel>[].obs;
  RxBool isLoading = false.obs;

  final String baseUrl = "https://harbhole.eihlims.com/Api/cart.php";

  @override
  void onInit() {
    super.onInit();
    fetchCartData();
  }

  /// Fetch Cart Data API
  Future<void> fetchCartData({String? userId}) async {
    try {
      isLoading.value = true;
      String url = "https://harbhole.eihlims.com/Api/cart.php?action=list";
      if (userId != null) {
        url += "&user_id=$userId";
      }

      final response = await http.get(Uri.parse(url));

      log("🟠 Cart List API Status: ${response.statusCode}");
      log("🟢 Cart List API Response: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse["success"] == true && jsonResponse["data"] != null) {
          List data = jsonResponse["data"];
          cartItems.assignAll(data.map((e) => CartModel.fromJson(e)).toList());
        } else {
          cartItems.clear();
          log("⚠️ No cart data found or returned false success");
        }
      } else {
        log("❌ Server error when fetching cart: ${response.statusCode}");
      }
    } catch (e) {
      log("❌ Exception in fetchCartData: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Add To Cart API
  Future<void> addToCart({
    required String userId,
    required String productId,
    required String productName,
    int quantity = 1,
  }) async {
    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse("https://harbhole.eihlims.com/Api/cart.php?action=add"),
        body: {
          "user_id": userId,
          "product_id": productId,
          "product_name": productName,
          "quantity": quantity.toString(),
        },
      );

      debugPrint("🟢 Add to Cart Response: ${response.body}");

      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse["success"] == true) {
        Get.snackbar(
          "Success",
          "Product added to cart!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        await fetchCartData(); // refresh cart
      } else {
        Get.snackbar(
          "Error",
          jsonResponse["message"] ?? "Failed to add to cart",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("🔴 Add to Cart Error: $e");
      Get.snackbar(
        "Error",
        "Something went wrong. Try again.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Delete from Cart API
  Future<void> removeFromCart({
    required String cartId,
    required String productId,
    required String userId,
  }) async {
    final url = Uri.parse(
      'https://harbhole.eihlims.com/Api/cart.php?action=delete',
    );

    final response = await http.post(
      url,
      body: {'cart_id': cartId, 'product_id': productId, 'user_id': userId},
    );

    print("🟡 Remove from Cart URL: $url");
    print("🟢 Remove from Cart Response: ${response.body}");

    final data = jsonDecode(response.body);
    if (data['success'] == true) {
      cartItems.removeWhere((item) => item.id == cartId);
      update(); // if using GetX
    } else {
      Get.snackbar("Error", data['message'] ?? "Failed to remove item");
    }
  }

  /// Utility getters remain same
  double get calculatedSubtotal {
    return cartItems.fold(0.0, (sum, item) {
      double price = double.tryParse(item.price) ?? 0.0;
      int qty = int.tryParse(item.qty) ?? 0;
      return sum + (price * qty);
    });
  }

  double get basePriceForItemsDisplay => calculatedSubtotal;
  double get displayDiscount => 0.0;
  double get deliveryCharges => calculatedSubtotal >= 500 ? 0.0 : 40.0;
  double get platformFee => cartItems.isEmpty ? 0.0 : 5.0;
  double get grandTotal => calculatedSubtotal + deliveryCharges + platformFee;
  int get totalItemsCount {
    return cartItems.fold(0, (sum, item) {
      int qty = int.tryParse(item.qty) ?? 0;
      return sum + qty;
    });
  }
}
