import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color mainOrange = Color(0xffF78520);

class CustomerOrderInvoice extends StatelessWidget {
  const CustomerOrderInvoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: EdgeInsets.all(Get.width / 35),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: Get.height / 30),

              // --- Invoice Header Section ---
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
              const SizedBox(height: 4),
              Text(
                'Order Number: ord202500001. Placed on Sep 13, 2025 5:53PM',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: Get.width / 30,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: Get.width / 2,
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
              const SizedBox(height: 20),
              InvoiceCard(
                title: 'Billing & Delivery',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'admin', // Customer Name
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: Get.width / 26,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildDetailRow(Icons.call, '8530009777'),
                    _buildDetailRow(Icons.location_on, 'Katargam (395001)'),
                  ],
                ),
              ),

              // --- 2. Payment Card ---
              InvoiceCard(
                title: 'Payment',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPriceRow('Mode:', 'RAZORPAY', isTotal: false),
                    _buildPriceRow(
                      'Status:',
                      'Paid',
                      isTotal: false,
                      valueColor: Colors.green.shade600,
                    ),
                    _buildPriceRow(
                      'Order Statue:',
                      'Pending',
                      isTotal: false,
                      valueColor: Colors.orange.shade600,
                    ),
                    _buildPriceRow(
                      'Razorpay Order Id:',
                      'order_RH5JcFx5Lro0yc',
                      isTotal: false,
                      valueColor: Colors.orange.shade600,
                    ),
                    _buildPriceRow(
                      'Razorpay Payment Id:',
                      'order_RH5Ji3eAyihZz',
                      isTotal: false,
                      valueColor: Colors.orange.shade600,
                    ),
                  ],
                ),
              ),

              // --- 3. Item List & Summary Card ---
              InvoiceCard(
                title: 'Items & Summary',
                showTitle: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- ITEM ROWS ---
                    _buildInvoiceItemRow(
                      name: 'DRY KACHORI(250.000G)',
                      quantityDetails: '10 * ₹110.00',
                      price: '₹1,100.00',
                    ),
                    const Divider(height: 1, thickness: 0.5),

                    _buildInvoiceItemRow(
                      name: 'MORI SEV(1KG)',
                      quantityDetails: '2 * ₹440.00',
                      price: '₹880.00',
                    ),
                    const Divider(height: 1, thickness: 0.5),

                    // --- PRICE SUMMARY ---
                    const SizedBox(height: 15),
                    _buildPriceRow('Subtotal', '₹1,980.00', isTotal: false),
                    _buildPriceRow('Tax(12.00%)', '₹237.60', isTotal: false),
                    _buildPriceRow(
                      'Shipping',
                      'Free',
                      isTotal: false,
                      valueColor: Colors.green.shade600,
                    ),

                    const SizedBox(height: 8),
                    const Divider(thickness: 1, height: 1),
                    const SizedBox(height: 8),

                    // Total Amount Row
                    _buildPriceRow('Total', '₹2,217.60', isTotal: true),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // --- Action Buttons ---
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
              SizedBox(height: Get.height / 20),
            ],
          ),
        ),
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
          const SizedBox(height: 4),
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
          Text(
            label,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: isTotal ? Get.width / 26 : Get.width / 30,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal ? Colors.black : Colors.grey.shade700,
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: isTotal ? Get.width / 26 : Get.width / 30,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
                color: valueColor ?? (isTotal ? Colors.black : Colors.black),
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
          const SizedBox(width: 8),
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

// Reusable Card Widget (adapted from your previous code)
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
            const SizedBox(height: 8),
          ],
          child,
        ],
      ),
    );
  }
}

// Reusable Button Widget (adapted from your previous code)
class InvoiceActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const InvoiceActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = mainOrange,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
