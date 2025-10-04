import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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

class OrderCartController extends GetxController {
  RxList<CartItem> cartItems = <CartItem>[].obs;

  @override
  void onInit() {
    super.onInit();
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

  void addItem(CartItem newItem) {
    var existingItem = cartItems.firstWhereOrNull(
      (item) => item.name == newItem.name && item.weight == newItem.weight,
    );
    if (existingItem != null) {
      existingItem.quantity.value += newItem.quantity.value;
    } else {
      cartItems.add(newItem);
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

  double get calculatedSubtotal => cartItems.fold(
    0.0,
    (sum, item) => sum + (item.price * item.quantity.value),
  );

  double get displayDiscount => 200.0;

  double get deliveryCharges => 0.0;
  double get platformFee => 5.0;

  double get basePriceForItemsDisplay {
    return 500.0;
  }

  double get grandTotal {
    return 300.0;
  }
}

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final OrderCartController orderCartController = Get.put(
    OrderCartController(),
  );

  int _selectedPaymentMethod = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: Get.width / 20),
              child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(thickness: 0.5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Color(0xff67BF86),
                          size: 28,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Delivery Address',
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Change',
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.deepOrange,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  'Rajesh Kumar\nA-304, Sunrise Apartments, Sector 15\nNoida, Uttar Pradesh - 201301\nPhone: +91 98765 43210',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(thickness: 0.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order Summery',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          '${orderCartController.cartItems.length} item',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    Divider(thickness: 0.5),
                    SizedBox(height: Get.height / 80),
                    ...orderCartController.cartItems
                        .map((item) => _buildCheckoutCartItemCard(item))
                        .toList(),
                    const Divider(height: 10, color: Colors.grey),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Get.height / 80),
                      child: Text(
                        'Payment Method',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    _buildPaymentMethodTile(
                      title: 'UPI (PhonePe, Gpay, Paytm )',
                      value: 0,
                    ),
                    _buildPaymentMethodTile(
                      title: 'Credit/Debit Card',
                      value: 1,
                    ),
                    _buildPaymentMethodTile(
                      title: 'Cash on Delivery',
                      value: 2,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Get.height / 80),
                      child: Text(
                        'Price Detail',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    _buildSummaryRow(
                      'Price(${orderCartController.cartItems.length} items)',
                      '₹${orderCartController.basePriceForItemsDisplay.toStringAsFixed(0)}',
                    ),
                    _buildSummaryRow(
                      'Discount',
                      '-₹${orderCartController.displayDiscount.toStringAsFixed(0)}',
                      valueColor: const Color(0xff67BF86),
                    ),
                    _buildSummaryRow(
                      'Delivery Charges',
                      'Free',
                      valueColor: const Color(0xff67BF86),
                    ),
                    _buildSummaryRow(
                      'Platform Fee',
                      '₹${orderCartController.platformFee.toStringAsFixed(0)}',
                      valueColor: const Color(0xff67BF86),
                    ),
                    Divider(thickness: 0.5),
                    SizedBox(height: Get.height / 80),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          '₹${orderCartController.grandTotal.toStringAsFixed(0)}', // Direct 300 from image
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'You will save ₹${orderCartController.displayDiscount.toStringAsFixed(0)} on this order',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 13,
                            color: Color(0xff67BF86),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height / 60),
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.local_shipping,
                              size: 24,
                              color: const Color(0xff67BF86),
                            ),
                            SizedBox(width: Get.width / 40),
                            Text(
                              'Expected Delivery\n3-5 business days',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height / 40),
                  ],
                );
              }),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Get.width / 25,
              vertical: Get.height / 50,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '₹${orderCartController.grandTotal.toStringAsFixed(0)}',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      'View Price details',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: Get.height / 15,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.bag_fill,
                        color: Colors.white,
                        size: 18,
                      ),
                      label: const Text(
                        'Place Order',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffF78520),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Get.width / 35),
            child: Text(
              'By placing this order, you agree to our Terms & Conditions',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutCartItemCard(CartItem item) {
    final imageWidth = Get.width / 3.5;

    return Padding(
      padding: EdgeInsets.only(bottom: Get.height / 60),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              item.imageUrl,
              width: imageWidth,
              height: imageWidth,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: Get.width / 30),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Tasty & Freshly',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,

                    color: Color(0xff6B7180),
                  ),
                ),
                Text(
                  item.weight,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff6B7180),
                  ),
                ),
                SizedBox(height: Get.height / 100),
                Text(
                  '₹${item.price.toStringAsFixed(0)}',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: AlignmentGeometry.bottomRight,
            child: Obx(
              () => Row(
                children: [
                  _buildQuantityButton(
                    Icons.remove,
                    onPressed: () => orderCartController.decreaseQuantity(item),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      item.quantity.value.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildQuantityButton(
                    Icons.add,
                    isAdd: true,
                    onPressed: () => orderCartController.increaseQuantity(item),
                  ),
                ],
              ),
            ),
          ),
        ],
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

  Widget _buildSummaryRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xff5D686E),
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: valueColor ?? Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodTile({required String title, required int value}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: const Color(0xffFAF7F6),
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: _selectedPaymentMethod == value
              ? Color(0xffF7663E)
              : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        onTap: () {
          setState(() {
            _selectedPaymentMethod = value;
          });
        },
        leading: Radio<int>(
          value: value,
          groupValue: _selectedPaymentMethod,
          onChanged: (int? newValue) {
            setState(() {
              _selectedPaymentMethod = newValue!;
            });
          },
          activeColor: Color(0xffF7663E),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
