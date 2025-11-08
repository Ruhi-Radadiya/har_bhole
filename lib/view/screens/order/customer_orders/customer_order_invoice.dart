import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/model/order_analytics_model/order_analytics_model.dart';

const Color mainOrange = Color(0xffF78520);

class CustomerOrderInvoice extends StatelessWidget {
  const CustomerOrderInvoice({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Get order data dynamically
    final OrderAnalyticsModel order = Get.arguments as OrderAnalyticsModel;

    // ✅ Extract product list (handle nulls)
    final products = order.products;

    // ✅ Calculate subtotal
    double subtotal = 0.0;
    for (var item in products) {
      double price = double.tryParse(item.price.toString()) ?? 0;
      double qty = double.tryParse(item.quantity.toString()) ?? 0;
      subtotal += price * qty;
    }

    // ✅ Apply tax (12%)
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
                  'Customer Order Invoice',
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
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Invoice',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: Get.width / 16.4,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height / 50),
                    Text(
                      'Order Number: ${order.orderNumber}  •  ${order.createdAt ?? ''}',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: Get.width / 30,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),

                    SizedBox(height: Get.height / 50),

                    // --- 1. Billing & Delivery ---
                    InvoiceCard(
                      title: 'Billing & Delivery',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.customerName,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: Get.width / 26,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height / 48),
                          _buildDetailRow(Icons.call, order.customerMobile),
                          _buildDetailRow(
                            Icons.location_on,
                            '${order.customerAddress} (${order.customerZipcode})',
                          ),
                        ],
                      ),
                    ),

                    // --- 2. Payment ---
                    InvoiceCard(
                      title: 'Payment',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPriceRow(
                            'Mode:',
                            order.paymentMethod.toUpperCase(),
                            isTotal: false,
                          ),
                          _buildPriceRow(
                            'Status:',
                            order.paymentStatus,
                            isTotal: false,
                            valueColor: (order.paymentStatus == 'Paid')
                                ? Colors.green.shade600
                                : Colors.orange.shade600,
                          ),
                          _buildPriceRow(
                            'Order Status:',
                            order.status,
                            isTotal: false,
                            valueColor: Colors.orange.shade600,
                          ),
                          if (order.razorpayOrderId != null)
                            _buildPriceRow(
                              'Razorpay Order Id:',
                              order.razorpayOrderId ?? '-',
                              isTotal: false,
                            ),
                          if (order.razorpayPaymentId != null)
                            _buildPriceRow(
                              'Razorpay Payment Id:',
                              order.razorpayPaymentId ?? '-',
                              isTotal: false,
                            ),
                        ],
                      ),
                    ),

                    // --- 3. Items & Summary ---
                    InvoiceCard(
                      title: 'Items & Summary',
                      showTitle: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var item in products) ...[
                            _buildInvoiceItemRow(
                              name: '${item.productName} (${item.netWeight})',
                              quantityDetails:
                                  '${item.quantity} × ₹${item.price}',
                              price:
                                  '₹${((double.tryParse(item.price.toString()) ?? 0) * (double.tryParse(item.quantity.toString()) ?? 0)).toStringAsFixed(2)}',
                            ),
                            const Divider(height: 1, thickness: 0.5),
                          ],
                          SizedBox(height: Get.height / 50),
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
                            valueColor: Colors.green.shade600,
                          ),
                          SizedBox(height: Get.height / 80),
                          Divider(thickness: 1, height: 1),
                          SizedBox(height: Get.height / 80),
                          _buildPriceRow(
                            'Total',
                            '₹${total.toStringAsFixed(2)}',
                            isTotal: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Get.height / 50),

                    // --- 4. Buttons ---
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            height: Get.height / 18,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: mainOrange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () => Get.back(),
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
                                backgroundColor: mainOrange,
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
                          backgroundColor: mainOrange,
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

  Widget _buildInvoiceItemRow({
    required String name,
    required String quantityDetails,
    required String price,
    Color? nameColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: Get.width / 26,
                fontWeight: FontWeight.bold,
                color: nameColor ?? Colors.black,
              ),
            ),
          ),
          SizedBox(height: Get.height / 150),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Qty $quantityDetails',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: Get.width / 30,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              Text(
                price,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: Get.width / 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(
    String label,
    String value, {
    required bool isTotal,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: isTotal ? Get.width / 26 : Get.width / 30,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                  color: isTotal ? Colors.black : Colors.grey.shade700,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: isTotal ? Get.width / 26 : Get.width / 30,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
                  color: valueColor ?? Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: mainOrange),
          SizedBox(width: Get.width / 30),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: Get.width / 28,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Reusable Card Widget ---
class InvoiceCard extends StatelessWidget {
  final Widget child;
  final String? title;
  final bool showTitle;

  const InvoiceCard({
    super.key,
    required this.child,
    this.title,
    this.showTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showTitle && title != null) ...[
            Text(
              title!,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: Get.width / 22.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: Get.height / 100),
          ],
          child,
        ],
      ),
    );
  }
}
