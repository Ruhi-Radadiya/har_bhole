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
                    const Divider(thickness: 0.5),
                    _buildAddressSection(),
                    const Divider(thickness: 0.5),
                    _buildOrderSummaryHeader(),
                    const Divider(thickness: 0.5),
                    SizedBox(height: Get.height / 50),
                    if (items.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
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

                    const Divider(height: 20),
                    _buildPriceDetails(),
                    const SizedBox(height: 20),
                    _buildDeliveryInfo(),
                    const SizedBox(height: 20),
                    _buildPaymentMethods(context),
                  ],
                );
              }),
            ),
          ),

          /// --- Bottom Total + Place Order Button ---
          _buildBottomBar(),
        ],
      ),
    );
  }

  // ------------------ UI PARTS --------------------

  Widget _buildAddressSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.location_on, color: Color(0xff67BF86), size: 28),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delivery Address',
                    style: GoogleFonts.poppins(
                      fontSize: Get.width / 22.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Change',
                    style: GoogleFonts.poppins(
                      fontSize: Get.width / 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepOrange,
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
    );
  }

  Widget _buildOrderSummaryHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Order Summary',
          style: GoogleFonts.poppins(
            fontSize: Get.width / 21,
            fontWeight: FontWeight.w600,
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
    );
  }

  Widget _buildPriceDetails() {
    return Column(
      children: [
        Text(
          'Price Details',
          style: GoogleFonts.poppins(
            fontSize: Get.width / 21,
            fontWeight: FontWeight.w600,
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
        const Divider(thickness: 0.5),
        _buildSummaryRow(
          'Total Amount',
          '₹${orderCartController.grandTotal.toStringAsFixed(0)}',
          isBold: true,
        ),
      ],
    );
  }

  Widget _buildDeliveryInfo() {
    return Row(
      children: [
        const Icon(Icons.local_shipping, size: 24, color: Color(0xff67BF86)),
        const SizedBox(width: 8),
        Text(
          'Expected Delivery\n3-5 business days',
          style: GoogleFonts.poppins(
            fontSize: Get.width / 25,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethods(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: GoogleFonts.poppins(
            fontSize: Get.width / 21,
            fontWeight: FontWeight.w600,
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
  }

  Widget _buildBottomBar() {
    return Obx(() {
      final total = orderCartController.grandTotal;
      return Container(
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
                  '₹${total.toStringAsFixed(0)}',
                  style: GoogleFonts.poppins(
                    fontSize: Get.width / 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () => _showPriceDetailsSheet(context),
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
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  // ----------------- ITEM CARD -------------------

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
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: Get.height / 50),
                Text(
                  '₹${item.price}',
                  style: GoogleFonts.poppins(
                    fontSize: Get.width / 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          // Quantity control
          Row(
            children: [
              _buildQuantityButton(
                Icons.remove,
                onPressed: () async {
                  await orderCartController.removeFromCart(
                    cartId: item.id,
                    userId: "1",
                    productId: item.productId ?? '',
                  );
                },
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
                onPressed: () async {
                  await orderCartController.addToCart(
                    userId: "1", // replace with PrefManager userId
                    productId: item.productId ?? '',
                    productName: item.productName,
                  );
                },
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
              fontSize: Get.width / 24,
              fontWeight: FontWeight.w500,
              color: const Color(0xff5D686E),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: Get.width / 24,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
              color: valueColor ?? Colors.black87,
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
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(leadingIcon, color: Colors.black87),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: Get.width / 26,
          ),
        ),
        subtitle: Text(
          subtitle ?? "",
          style: TextStyle(color: Colors.grey[600], fontSize: Get.width / 30),
        ),
        trailing: Icon(
          selectedValue == value
              ? Icons.radio_button_checked
              : Icons.radio_button_off,
          color: Colors.orange,
        ),
      ),
    );
  }

  void _onPlaceOrderPressed() {
    final total = orderCartController.grandTotal;
    Get.to(() => OrderSuccessScreen(totalAmount: total))?.then((_) {
      orderCartController.cartItems.clear();
    });
  }

  void _showPriceDetailsSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) => Padding(
        padding: EdgeInsets.all(Get.width / 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Price Details",
              style: GoogleFonts.poppins(
                fontSize: Get.width / 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12),
            _buildSummaryRow(
              'Price (${orderCartController.totalItemsCount} items)',
              '₹${orderCartController.basePriceForItemsDisplay.toStringAsFixed(0)}',
            ),
            _buildSummaryRow(
              'Delivery Charges',
              orderCartController.deliveryCharges == 0 ? 'Free' : '₹40',
            ),
            const Divider(),
            _buildSummaryRow(
              'Total Amount',
              '₹${orderCartController.grandTotal.toStringAsFixed(0)}',
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }
}

// --- Success Screen ---
class OrderSuccessScreen extends StatelessWidget {
  final double totalAmount;
  const OrderSuccessScreen({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width / 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 120,
              ),
              const SizedBox(height: 20),
              Text(
                "Order Placed!",
                style: GoogleFonts.poppins(
                  fontSize: Get.width / 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Your order has been placed successfully.\nTotal: ₹${totalAmount.toStringAsFixed(0)}",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: Get.width / 28,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  navigationController.getIndex(index: 0);
                  navigationController.changePageView(index: 0);
                  Get.offAllNamed(Routes.bottomNavigationBar);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffF78520),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
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
