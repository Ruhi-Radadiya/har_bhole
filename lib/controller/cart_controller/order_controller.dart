import 'dart:convert';
import 'dart:developer' as logger;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/cart_model/cart_model.dart';

class OrderCartController extends GetxController {
  static OrderCartController get instance => Get.find();

  // Observable list for cart items
  final RxList<CartModel> cartItems = <CartModel>[].obs;
  final RxBool isLoading = false.obs;

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

      logger.log("🟠 Cart List API Status: ${response.statusCode}");
      logger.log("🟢 Cart List API Response: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse["success"] == true && jsonResponse["data"] != null) {
          List data = jsonResponse["data"];
          cartItems.assignAll(data.map((e) => CartModel.fromJson(e)).toList());
        } else {
          cartItems.clear();
          logger.log("⚠️ No cart data found or returned false success");
        }
      } else {
        logger.log("❌ Server error when fetching cart: ${response.statusCode}");
      }
    } catch (e) {
      logger.log("❌ Exception in fetchCartData: $e");
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

      // Check if item already exists in cart
      final existingItemIndex = cartItems.indexWhere(
        (item) => item.productId == productId,
      );

      // If item exists, update quantity instead of adding new item
      if (existingItemIndex != -1) {
        final existingItem = cartItems[existingItemIndex];
        final newQuantity = (int.tryParse(existingItem.qty) ?? 0) + quantity;

        // Call update cart API instead of add to cart
        final updateResponse = await http.post(
          Uri.parse("https://harbhole.eihlims.com/Api/cart.php?action=update"),
          body: {"id": existingItem.id, "quantity": newQuantity.toString()},
        );

        logger.log("🟢 Update Cart Response: ${updateResponse.body}");
        final updateJson = jsonDecode(updateResponse.body);

        if (updateJson["success"] == true) {
          await fetchCartData(); // refresh cart
          Get.snackbar(
            "Success",
            "Cart updated!",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          throw Exception(updateJson["message"] ?? "Failed to update cart");
        }
        return;
      }

      // If item doesn't exist, add new item
      final response = await http.post(
        Uri.parse("https://harbhole.eihlims.com/Api/cart.php?action=add"),
        body: {
          "user_id": userId,
          "product_id": productId,
          "product_name": productName,
          "quantity": quantity.toString(),
        },
      );

      logger.log("🟢 Add to Cart Response: ${response.body}");

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
        throw Exception(jsonResponse["message"] ?? "Failed to add to cart");
      }
    } catch (e) {
      logger.log("🔴 Add to Cart Error: $e");
      Get.snackbar(
        "Error",
        e.toString().replaceAll("Exception: ", ""),
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
    try {
      // Validate cartId
      if (cartId.isEmpty) {
        debugPrint("🔴 Error: Cart ID is empty");
        Get.snackbar(
          "Error",
          "Invalid cart item. Please try again.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      isLoading.value = true;

      final url = Uri.parse(
        'https://harbhole.eihlims.com/Api/cart.php?action=delete',
      );

      final cartIdInt = int.tryParse(cartId) ?? 0;

      debugPrint(
        "🟡 Remove from Cart Request: cart_id=$cartIdInt, product_id=$productId, user_id=$userId",
      );

      final response = await http.post(
        url,
        body: jsonEncode({'id': cartIdInt}),
        headers: {'Content-Type': 'application/json'},
      );

      debugPrint(
        "🟢 Remove from Cart Response: ${response.statusCode} - ${response.body}",
      );

      // Check if response is valid JSON
      Map<String, dynamic> data;
      try {
        data = jsonDecode(response.body);
      } catch (e) {
        debugPrint("🔴 Error parsing response: $e");
        throw Exception("Invalid response from server");
      }

      if (response.statusCode == 200 && data['success'] == true) {
        // Remove the item from the local list
        // This will automatically trigger UI updates
        cartItems.removeWhere((item) => item.id == cartId);

        Get.snackbar(
          "Success",
          "Item removed from cart",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        String errorMessage = data['message'] ?? "Failed to remove item";
        debugPrint("🔴 Remove from Cart Error: $errorMessage");

        Get.snackbar(
          "Error",
          errorMessage,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("🔴 Remove from Cart Error: $e");
      Get.snackbar(
        "Error",
        "Failed to remove item. Please try again.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
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
