import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/routes/routes.dart';

class CartItem {
  String imageUrl;
  String name;
  String weight;
  double price;
  double originalPrice;
  RxInt quantity;

  CartItem({
    required this.imageUrl,
    required this.name,
    required this.weight,
    required this.price,
    required this.originalPrice,
    required int quantity,
  }) : quantity = quantity.obs;
}

// --- CartController renamed to CartDataController ---
class CartDataController extends GetxController {
  RxList<CartItem> cartItems = <CartItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with dummy data (3 items)
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
        imageUrl: 'asset/images/home/samosa.png',
        name: 'Samosa',
        weight: '500g',
        price: 100,
        originalPrice: 200,
        quantity: 3,
      ),
      CartItem(
        imageUrl: 'asset/images/home/fafda.png',
        name: 'Fafda',
        weight: '250g',
        price: 100,
        originalPrice: 200,
        quantity: 1,
      ),
    ]);
  }

  void addItem(CartItem item) {
    // Check if item already exists to avoid duplicates
    var existingItem = cartItems.firstWhereOrNull(
      (i) => i.name == item.name && i.weight == item.weight,
    );

    if (existingItem != null) {
      existingItem.quantity.value += item.quantity.value;
    } else {
      cartItems.add(item);
    }
  }

  void removeItem(CartItem item) {
    cartItems.remove(item);
  }

  void increaseQuantity(CartItem item) {
    item.quantity.value++;
  }

  void decreaseQuantity(CartItem item) {
    if (item.quantity.value > 1) {
      item.quantity.value--;
    } else {
      removeItem(item);
    }
  }

  // --- Computed Properties (Getters) ---

  // Total amount based on selling price (Subtotal)
  double get subtotal => cartItems.fold(
    0.0,
    (sum, item) => sum + (item.price * item.quantity.value),
  );

  // Discount saved (Original Price - Selling Price)
  double get totalDiscount => cartItems.fold(
    0.0,
    (sum, item) =>
        sum + ((item.originalPrice - item.price) * item.quantity.value),
  );

  // Total cost before fees/delivery (Same as subtotal if item.price is the final price)
  double get totalSellingCost => subtotal;

  // Hardcoded fees/delivery for Checkout screen clarity:
  double get platformFee => 0.0;
  double get deliveryCharges => 0.0;

  // Grand Total calculation for Checkout
  double get grandTotal {
    return totalSellingCost + platformFee + deliveryCharges;
  }
}

class ShoppingCardScreen extends StatelessWidget {
  ShoppingCardScreen({super.key});
  final CartDataController controller = Get.put(CartDataController());

  @override
  Widget build(BuildContext context) {
    // Dummy items
    controller.cartItems.assignAll([
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
        quantity: 3,
      ),
      CartItem(
        imageUrl: 'asset/images/home/khaman.png',
        name: 'Samosa',
        weight: '500g',
        price: 100,
        originalPrice: 200,
        quantity: 3,
      ),
    ]);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Shopping Cart',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: Get.width / 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.cartItems.isEmpty
            ? Center(
                child: Text(
                  "Your cart is empty",
                  style: TextStyle(
                    fontSize: Get.width / 22.5,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : SingleChildScrollView(
                padding: EdgeInsets.only(bottom: Get.height / 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(Get.width / 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Shopping Cart',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: Get.width / 21,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            '${controller.cartItems.length} Item(s) in your basket',
                            style: TextStyle(
                              fontSize: Get.width / 28,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: controller.cartItems
                          .map((item) => _buildCartItemCard(item))
                          .toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: Get.width / 15,
                          vertical: Get.height / 40,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25.0),
                          ),
                          border: Border.all(color: Colors.grey, width: 0.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Order Summary',
                              style: TextStyle(
                                fontSize: Get.width / 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: Get.height / 60),
                            _buildSummaryRow(
                              'Subtotal',
                              '₹${controller.subtotal}',
                            ),
                            _buildSummaryRow(
                              'Discount',
                              '-₹${controller.totalDiscount}',
                              valueColor: Color(0xff67BF86),
                            ),
                            _buildSummaryRow(
                              'Delivery charges',
                              'Free',
                              valueColor: Color(0xff67BF86),
                            ),
                            const Divider(height: 20),
                            _buildSummaryRow(
                              'Grand Total',
                              '₹${controller.grandTotal}',
                              valueColor: Color(0xffF7663E),
                              isGrandTotal: true,
                            ),
                            SizedBox(height: Get.height / 40),
                            SizedBox(
                              height: Get.height / 18,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(Routes.checkOut);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffF78520),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  'Proceed to Checkout',
                                  style: TextStyle(
                                    fontSize: Get.width / 26,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: Get.height / 60),
                            SizedBox(
                              height: Get.height / 18,
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  CupertinoIcons.bag_fill,
                                  color: Colors.black,
                                ),
                                label: Text(
                                  'Continue Shopping',
                                  style: TextStyle(
                                    fontSize: Get.width / 26,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade200,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  side: BorderSide.none,
                                  elevation: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height / 60),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildCartItemCard(CartItem item) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width / 30,
        vertical: Get.height / 100,
      ),
      child: Container(
        height: Get.height / 6.5,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: const Color(0xffF2F3F5), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                item.imageUrl,
                width: Get.width / 3.5,
                height: Get.height / 5,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: Get.width / 35),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: TextStyle(
                          fontSize: Get.width / 22.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Tasty & Freshly',
                        style: TextStyle(
                          fontSize: Get.width / 30,
                          color: Color(0xff6B7180),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        item.weight,
                        style: TextStyle(
                          fontSize: Get.width / 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff6B7180),
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => Row(
                      children: [
                        _buildQuantityButton(
                          Icons.remove,
                          onPressed: () => controller.decreaseQuantity(item),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            item.quantity.value.toString(),
                            style: TextStyle(
                              fontSize: Get.width / 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        _buildQuantityButton(
                          Icons.add,
                          isAdd: true,
                          onPressed: () => controller.increaseQuantity(item),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => controller.removeItem(item),
                  child: const Icon(
                    Icons.delete,
                    color: Color(0xffE83C4B),
                    size: 24,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₹${item.price.toStringAsFixed(0)}',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: Get.width / 22.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      '₹${item.originalPrice.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: Get.width / 30,
                        color: Color(0xff9EA4B0),
                        decoration: TextDecoration.lineThrough,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityButton(
    IconData icon, {
    bool isAdd = false,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: Get.width / 18,
        height: Get.width / 18,
        decoration: BoxDecoration(
          color: isAdd ? const Color(0xffF7663E) : Colors.grey.shade300,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16, color: isAdd ? Colors.white : Colors.black),
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    Color? valueColor,
    bool isGrandTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: isGrandTotal ? Get.width / 20 : Get.width / 24,
                fontWeight: isGrandTotal ? FontWeight.w600 : FontWeight.w500,
                color: isGrandTotal ? Colors.black : Color(0xff5D686E),
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: isGrandTotal ? Get.width / 20 : Get.width / 24,
                fontWeight: isGrandTotal ? FontWeight.w600 : FontWeight.w500,
                color:
                    valueColor ?? (isGrandTotal ? Colors.red : Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
