import 'package:get/get.dart';

import '../../view/screens/shopping/checkout.dart';

class OrderCartController extends GetxController {
  RxList<CartItem> cartItems = <CartItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    // sample initial data (same as your old UI). Your Products screen can add items to cartItems
    cartItems.assignAll([
      CartItem(
        imageUrl: 'asset/images/home/khaman.png',
        name: 'Khaman',
        weight: '1kg',
        price: 200,
        originalPrice: 400,
        quantity: 2,
      ),
      CartItem(
        imageUrl: 'asset/images/home/khaman.png',
        name: 'Samosa',
        weight: '500g',
        price: 100,
        originalPrice: 200,
        quantity: 2,
      ),
      CartItem(
        imageUrl: 'asset/images/home/khaman.png',
        name: 'Mix Farsan',
        weight: '500g',
        price: 200,
        originalPrice: 300,
        quantity: 1,
      ),
    ]);
  }

  // Add item (merge if same product+weight)
  void addItem(CartItem newItem) {
    final index = cartItems.indexWhere(
      (i) => i.name == newItem.name && i.weight == newItem.weight,
    );
    if (index >= 0) {
      cartItems[index].quantity.value += newItem.quantity.value;
      cartItems.refresh();
    } else {
      cartItems.add(newItem);
    }
  }

  void removeItem(CartItem item) {
    cartItems.remove(item);
  }

  void increaseQuantity(CartItem item) {
    item.quantity.value++;
    cartItems.refresh();
  }

  void decreaseQuantity(CartItem item) {
    if (item.quantity.value > 1) {
      item.quantity.value--;
      cartItems.refresh();
    } else {
      removeItem(item);
    }
  }

  // subtotal: sum of (selling price * qty)
  double get calculatedSubtotal => cartItems.fold(
    0.0,
    (sum, item) => sum + (item.price * item.quantity.value),
  );

  // base price for display: sum of (originalPrice * qty)
  double get basePriceForItemsDisplay => cartItems.fold(
    0.0,
    (sum, item) => sum + (item.originalPrice * item.quantity.value),
  );

  // discount = base - subtotal (if base > subtotal). else 0
  double get displayDiscount {
    final d = basePriceForItemsDisplay - calculatedSubtotal;
    return d > 0 ? d : 0.0;
  }

  // delivery charges: free for subtotal >= 500, else 40 (adjust as needed)
  double get deliveryCharges => calculatedSubtotal >= 500 ? 0.0 : 40.0;

  double get platformFee => cartItems.isEmpty ? 0.0 : 5.0;

  // final payable amount
  double get grandTotal => calculatedSubtotal + deliveryCharges + platformFee;

  // convenience totalItems count
  int get totalItemsCount =>
      cartItems.fold(0, (sum, item) => sum + item.quantity.value);
}
