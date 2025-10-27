import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/cart_model/cart_model.dart';

class OrderCartController extends GetxController {
  RxList<CartModel> cartItems = <CartModel>[].obs;
  RxBool isLoading = false.obs;

  final String baseUrl =
      "http://192.168.0.118/har_bhole_farsan/Api/cart.php?action=list";

  @override
  void onInit() {
    super.onInit();
    fetchCartData();
  }

  /// ✅ Fetch Cart Data from API
  Future<void> fetchCartData() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(baseUrl));

      log("🟠 Cart API Status: ${response.statusCode}");
      log("🟢 Cart API Response: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse["success"] == true && jsonResponse["data"] != null) {
          List data = jsonResponse["data"];
          cartItems.assignAll(data.map((e) => CartModel.fromJson(e)).toList());
        } else {
          cartItems.clear();
          log("⚠️ No cart data found");
        }
      } else {
        log("❌ Server error: ${response.statusCode}");
      }
    } catch (e) {
      log("❌ Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ Increase quantity
  void increaseQuantity(CartModel item) {
    int currentQty = int.tryParse(item.qty) ?? 1;
    int newQty = currentQty + 1;
    item.qty = newQty.toString();
    cartItems.refresh();
  }

  /// ✅ Decrease quantity
  void decreaseQuantity(CartModel item) {
    int currentQty = int.tryParse(item.qty) ?? 1;
    if (currentQty > 1) {
      int newQty = currentQty - 1;
      item.qty = newQty.toString();
      cartItems.refresh();
    } else {
      removeItem(item);
    }
  }

  /// ✅ Remove item
  void removeItem(CartModel item) {
    cartItems.remove(item);
  }

  /// ✅ Subtotal (price * qty)
  double get calculatedSubtotal {
    return cartItems.fold(0.0, (sum, item) {
      double price = double.tryParse(item.price) ?? 0.0;
      int qty = int.tryParse(item.qty) ?? 0;
      return sum + (price * qty);
    });
  }

  /// ✅ Base price for MRP display (same as subtotal if no discount)
  double get basePriceForItemsDisplay => calculatedSubtotal;

  /// ✅ Discount (0 for now)
  double get displayDiscount => 0.0;

  /// ✅ Delivery charges
  double get deliveryCharges => calculatedSubtotal >= 500 ? 0.0 : 40.0;

  /// ✅ Platform fee
  double get platformFee => cartItems.isEmpty ? 0.0 : 5.0;

  /// ✅ Grand total
  double get grandTotal => calculatedSubtotal + deliveryCharges + platformFee;

  /// ✅ Total items count
  int get totalItemsCount {
    return cartItems.fold(0, (sum, item) {
      int qty = int.tryParse(item.qty) ?? 0;
      return sum + qty;
    });
  }
}
