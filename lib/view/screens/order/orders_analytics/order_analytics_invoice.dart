import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../model/order_analytics_model/order_analytics_model.dart';

const Color mainOrange = Color(0xffF78520);

class OrderAnalyticsInvoice extends StatelessWidget {
  const OrderAnalyticsInvoice({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderAnalyticsModel order = Get.arguments as OrderAnalyticsModel;
    double subtotal = order.products.fold(
      0.0,
      (sum, product) => sum + (product.subtotal.toDouble()),
    );
    double tax = subtotal * 0.12;
    double total = subtotal + tax;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          SizedBox(height: Get.height / 30),
          Container(
            padding: EdgeInsets.only(
              left: Get.width / 25,
              right: Get.width / 25,
              bottom: Get.height / 100,
            ),
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xffF78520)),
                  onPressed: () => Get.back(),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(minWidth: Get.width / 15),
                ),
                SizedBox(width: Get.width / 100),
                Text(
                  'Invoice',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: Get.width / 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xffF78520),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(Get.width / 30),
              child: Container(
                padding: EdgeInsets.all(Get.width / 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔸 Order Info
                    Text(
                      'Order #${order.orderNumber}',
                      style: GoogleFonts.poppins(
                        fontSize: Get.width / 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Placed on ${order.createdAt}',
                      style: GoogleFonts.poppins(
                        fontSize: Get.width / 30,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    SizedBox(height: Get.height / 50),

                    // 🔸 Billing Info
                    CustomInvoiceCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Billing & Delivery',
                            style: GoogleFonts.poppins(
                              fontSize: Get.width / 22.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            order.customerName,
                            style: GoogleFonts.poppins(
                              fontSize: Get.width / 26,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 5),
                          _buildIconText(Icons.call, order.customerMobile),
                          _buildIconText(
                            Icons.location_on,
                            '${order.customerAddress} (${order.customerZipcode})',
                          ),
                        ],
                      ),
                    ),

                    // 🔸 Payment Info
                    CustomInvoiceCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Payment',
                            style: GoogleFonts.poppins(
                              fontSize: Get.width / 22.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          _buildDetailRow('Mode:', order.paymentMethod),
                          _buildDetailRow('Status:', order.paymentStatus),
                          _buildDetailRow('Order Status:', order.status),
                        ],
                      ),
                    ),

                    // 🔸 Product List
                    CustomInvoiceCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...order.products.map((p) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildItemRow(
                                  "${p.productName} (${p.netWeight})",
                                  "${p.quantity} × ₹${p.price}",
                                  "₹${p.subtotal}",
                                ),
                                const Divider(height: 20, thickness: 0.5),
                              ],
                            );
                          }),
                          _buildPriceRow(
                            'Subtotal',
                            '₹${subtotal.toStringAsFixed(2)}',
                            isTotal: false,
                          ),
                          _buildPriceRow(
                            'Tax (12%)',
                            '₹${tax.toStringAsFixed(2)}',
                            isTotal: false,
                          ),
                          _buildPriceRow(
                            'Shipping',
                            'Free',
                            isTotal: false,
                            valueColor: Colors.green.shade700,
                          ),
                          Divider(thickness: 1),
                          _buildPriceRow(
                            'Total',
                            '₹${total.toStringAsFixed(2)}',
                            isTotal: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Get.height / 40),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            height: Get.height / 18,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffF78520),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                "Back to order",
                                style: GoogleFonts.poppins(
                                  fontSize: Get.width / 28,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: Get.width / 30),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            height: Get.height / 18,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffF78520),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                "View Pdf",
                                style: GoogleFonts.poppins(
                                  fontSize: Get.width / 28,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height / 50),
                    SizedBox(
                      width: double.infinity,
                      height: Get.height / 18,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffF78520),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Download PDF",
                          style: GoogleFonts.poppins(
                            fontSize: Get.width / 22.5,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: Get.height / 20),
        ],
      ),
    );
  }

  // 🔹 Helpers
  Widget _orangeButton(String text, VoidCallback onPressed) {
    return SizedBox(
      height: Get.height / 18,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: mainOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: Get.width / 25,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: mainOrange),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: Get.width / 30,
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: Get.width / 30,
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: Get.width / 30,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemRow(String name, String qty, String price) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: GoogleFonts.poppins(
            fontSize: Get.width / 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Qty $qty',
              style: GoogleFonts.poppins(
                fontSize: Get.width / 30,
                color: Colors.grey.shade700,
              ),
            ),
            Text(
              price,
              style: GoogleFonts.poppins(
                fontSize: Get.width / 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceRow(
    String label,
    String value, {
    required bool isTotal,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: isTotal ? Get.width / 26 : Get.width / 30,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: isTotal ? Get.width / 26 : Get.width / 30,
              fontWeight: FontWeight.w600,
              color: valueColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomInvoiceCard extends StatelessWidget {
  final Widget child;
  const CustomInvoiceCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}
