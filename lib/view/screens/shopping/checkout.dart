import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/model/cart_model/cart_model.dart';

import '../../../main.dart';
import '../../../routes/routes.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedPaymentMethod = 2; // default: Cash on Delivery

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
        title: Text(
          'Checkout',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: Get.width / 18,
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
                final items = orderCartController.cartItems;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(thickness: 0.5),

                    // Address section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Color(0xff67BF86),
                          size: 28,
                        ),
                        const SizedBox(width: 10),
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
                                      textStyle: TextStyle(
                                        fontSize: Get.width / 22.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Change',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: Get.width / 26,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.deepOrange,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Rajesh Kumar\nA-304, Sunrise Apartments, Sector 15\nNoida, Uttar Pradesh - 201301\nPhone: +91 98765 43210',
                                style: TextStyle(
                                  fontSize: Get.width / 26,
                                  color: Colors.grey.shade600,
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
                          'Order Summary',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: Get.width / 21,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          '${orderCartController.totalItemsCount} items',
                          style: TextStyle(
                            fontSize: Get.width / 26,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    Divider(thickness: 0.5),
                    const SizedBox(height: 10),

                    if (items.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Center(
                          child: Text(
                            "No items in cart",
                            style: GoogleFonts.poppins(
                              fontSize: Get.width / 22,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                    else
                      ...items.map((item) => _buildCheckoutCartItemCard(item)),

                    const Divider(height: 10, color: Colors.grey),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Get.height / 80),
                      child: Text(
                        'Price Details',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: Get.width / 21,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    _buildSummaryRow(
                      'Price (${orderCartController.totalItemsCount} items)',
                      '₹${orderCartController.basePriceForItemsDisplay.toStringAsFixed(0)}',
                    ),
                    _buildSummaryRow(
                      'Discount',
                      '-₹${orderCartController.displayDiscount.toStringAsFixed(0)}',
                      valueColor: const Color(0xff67BF86),
                    ),
                    _buildSummaryRow(
                      'Delivery Charges',
                      orderCartController.deliveryCharges == 0.0
                          ? 'Free'
                          : '₹${orderCartController.deliveryCharges.toStringAsFixed(0)}',
                      valueColor: const Color(0xff67BF86),
                    ),
                    _buildSummaryRow(
                      'Platform Fee',
                      '₹${orderCartController.platformFee.toStringAsFixed(0)}',
                      valueColor: const Color(0xff67BF86),
                    ),

                    Divider(thickness: 0.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: Get.width / 21,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          '₹${orderCartController.grandTotal.toStringAsFixed(0)}',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: Get.width / 21,
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
                          textStyle: TextStyle(
                            fontSize: Get.width / 28,
                            color: const Color(0xff67BF86),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Icon(
                          Icons.local_shipping,
                          size: 24,
                          color: Color(0xff67BF86),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Expected Delivery\n3-5 business days',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: Get.width / 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    Text(
                      'Payment Method',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: Get.width / 21,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildPaymentMethodTile(
                      context: context,
                      title: "Pay on delivery",
                      subtitle: "UPI / Cash",
                      leadingIcon: Icons.wallet_outlined,
                      value: 1,
                      selectedValue: _selectedPaymentMethod,
                      onTap: () => setState(() => _selectedPaymentMethod = 1),
                    ),
                    _buildPaymentMethodTile(
                      context: context,
                      title: "Net Banking",
                      subtitle: "Bank Transfer / UPI",
                      leadingIcon: Icons.account_balance,
                      value: 2,
                      selectedValue: _selectedPaymentMethod,
                      onTap: () => setState(() => _selectedPaymentMethod = 2),
                    ),
                    _buildPaymentMethodTile(
                      context: context,
                      title: "HDFC Bank",
                      subtitle: "Credit / Debit Card",
                      leadingIcon: Icons.credit_card,
                      value: 3,
                      selectedValue: _selectedPaymentMethod,
                      onTap: () => setState(() => _selectedPaymentMethod = 3),
                    ),
                  ],
                );
              }),
            ),
          ),

          // Bottom bar
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
            child: Obx(() {
              final total = orderCartController.grandTotal;
              return Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '₹${total.toStringAsFixed(0)}',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: Get.width / 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showPriceDetailsSheet(context),
                        child: Text(
                          'View Price details',
                          style: TextStyle(
                            fontSize: Get.width / 30,
                            color: Colors.grey.shade600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: Get.height / 15,
                      child: ElevatedButton.icon(
                        onPressed: orderCartController.cartItems.isEmpty
                            ? null
                            : _onPlaceOrderPressed,
                        icon: const Icon(
                          CupertinoIcons.bag_fill,
                          color: Colors.white,
                          size: 18,
                        ),
                        label: Text(
                          'Place Order',
                          style: TextStyle(
                            fontSize: Get.width / 28,
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
              );
            }),
          ),
          Padding(
            padding: EdgeInsets.all(Get.width / 35),
            child: Text(
              'By placing this order, you agree to our Terms & Conditions',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Get.width / 36,
                color: Colors.grey.shade500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Order placed action ---
  void _onPlaceOrderPressed() {
    final total = orderCartController.grandTotal;
    Get.to(() => OrderSuccessScreen(totalAmount: total))?.then((_) {
      orderCartController.cartItems.clear();
    });
  }

  // --- Price detail sheet ---
  void _showPriceDetailsSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (context) {
        return Obx(() {
          final c = orderCartController;
          return Padding(
            padding: EdgeInsets.all(Get.width / 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Price Details',
                  style: GoogleFonts.poppins(
                    fontSize: Get.width / 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: Get.height / 60),
                _buildSummaryRow(
                  'Price (${c.totalItemsCount} items)',
                  '₹${c.basePriceForItemsDisplay.toStringAsFixed(0)}',
                ),
                _buildSummaryRow(
                  'Discount',
                  '-₹${c.displayDiscount.toStringAsFixed(0)}',
                  valueColor: const Color(0xff67BF86),
                ),
                _buildSummaryRow(
                  'Delivery Charges',
                  c.deliveryCharges == 0
                      ? 'Free'
                      : '₹${c.deliveryCharges.toStringAsFixed(0)}',
                ),
                _buildSummaryRow(
                  'Platform Fee',
                  '₹${c.platformFee.toStringAsFixed(0)}',
                ),
                const Divider(),
                _buildSummaryRow(
                  'Total Amount',
                  '₹${c.grandTotal.toStringAsFixed(0)}',
                  isBold: true,
                ),
                SizedBox(height: Get.height / 40),
              ],
            ),
          );
        });
      },
    );
  }

  // --- Cart item card using Map instead of model ---
  Widget _buildCheckoutCartItemCard(CartModel item) {
    final imageWidth = Get.width / 3.5;

    return Padding(
      padding: EdgeInsets.only(bottom: Get.height / 60),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              "asset/images/home/khaman.png",
              width: imageWidth,
              height: imageWidth,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: Get.width / 30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: TextStyle(
                    fontSize: Get.width / 22.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  item.grams,
                  style: TextStyle(
                    fontSize: Get.width / 30,
                    color: const Color(0xff6B7180),
                  ),
                ),
                SizedBox(height: Get.height / 100),
                Text(
                  '₹${item.price}',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: Get.width / 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Quantity controls
          Row(
            children: [
              _buildQuantityButton(
                Icons.remove,
                onPressed: () => orderCartController.decreaseQuantity(item),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  item.qty.toString(),
                  style: TextStyle(
                    fontSize: Get.width / 26,
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

  Widget _buildSummaryRow(
    String label,
    String value, {
    Color? valueColor,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: Get.width / 24,
                fontWeight: FontWeight.w500,
                color: const Color(0xff5D686E),
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: Get.width / 24,
                fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
                color: valueColor ?? Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodTile({
    required BuildContext context,
    required String title,
    required String? subtitle,
    required IconData leadingIcon,
    required int value,
    required int selectedValue,
    required void Function() onTap,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15.0),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Row(
              children: [
                Icon(leadingIcon, size: 24, color: Colors.black87),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: screenWidth / 26,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      if (subtitle != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text(
                            subtitle!,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: screenWidth / 30,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: Get.width / 28),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- Success screen ---
class OrderSuccessScreen extends StatelessWidget {
  final double totalAmount;
  const OrderSuccessScreen({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width / 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline, color: Colors.green, size: 120),
              SizedBox(height: Get.height / 40),
              Text(
                "Order Placed!",
                style: GoogleFonts.poppins(
                  fontSize: Get.width / 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: Get.height / 80),
              Text(
                "Your order has been placed successfully.\nTotal: ₹${totalAmount.toStringAsFixed(0)}",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: Get.width / 28,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: Get.height / 30),
              ElevatedButton(
                onPressed: () {
                  navigationController.getIndex(index: 0);
                  navigationController.changePageView(index: 0);

                  Get.offAllNamed(Routes.bottomNavigationBar);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffF78520),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Continue Shopping",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
