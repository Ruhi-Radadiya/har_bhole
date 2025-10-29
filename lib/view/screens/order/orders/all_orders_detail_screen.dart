import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// Define the main color used across your application
const Color mainOrange = Color(0xffF78520);

class AllOrdersDetailScreen extends StatelessWidget {
  const AllOrdersDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example data for the 5-column table
    final List<Map<String, String>> sampleItems = [
      {
        'name': 'DRY KACHORI',
        'netWt': '250.000g',
        'price': '₹110.00',
        'qty': '10',
        'total': '₹1,100.00',
      },
      {
        'name': 'SAMOSA (Spicy Variant)',
        'netWt': '500.000g',
        'price': '₹100.00',
        'qty': '2',
        'total': '₹200.00',
      },
      {
        'name': 'Rajvadi Peda (High Quality)',
        'netWt': '1000.00g',
        'price': '₹500.00',
        'qty': '1',
        'total': '₹500.00',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          SizedBox(height: Get.height / 30),
          // --- Custom AppBar Section ---
          Container(
            padding: EdgeInsets.only(
              left: Get.width / 25,
              right: Get.width / 25,
              bottom: Get.height / 100,
            ),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                SizedBox(height: Get.height / 100),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color(0xffF78520),
                      ),
                      onPressed: () => Get.back(),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(minWidth: Get.width / 15),
                    ),
                    Text(
                      'Order Details',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: Get.width / 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // --- Scrollable Content ---
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(Get.width / 30),
              child: Column(
                children: [
                  Container(
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
                        // Order Header
                        Text(
                          'Order #ord202500002',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: Get.width / 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height / 70),

                        // 1. Customer Card
                        CustomInvoiceCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Customer',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: Get.width / 21,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                'admin', // Name
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: Get.width / 30,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height / 70),
                              _buildIconText(Icons.call, '8530009777'),
                              _buildIconText(
                                Icons.location_on,
                                'Katargam (395001)',
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Order Info',
                          style: TextStyle(
                            fontSize: Get.width / 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CustomInvoiceCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDetailRow('Amount:', '₹2,090.00'),
                              _buildDetailRow('Status:', 'Pending'),
                              _buildDetailRow('Payment:', 'Pending'),
                              _buildDetailRow('Method:', 'COD'),
                              _buildDetailRow(
                                'Created:',
                                'Sep 16, 2025 11:22 PM',
                              ),
                              _buildDetailRow(
                                'Updated:',
                                'Sep 16, 2025 11:22 PM',
                              ),
                            ],
                          ),
                        ),
                        CustomInvoiceCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 5-Column Item Table
                              _buildItemTable(items: sampleItems),

                              const Divider(height: 30, thickness: 1),

                              // Price Summary (Totals reflect sampleItems)
                              _buildPriceRow(
                                'Subtotal',
                                '₹1,800.00', // Example subtotal for sampleItems
                                isTotal: false,
                              ),
                              _buildPriceRow(
                                'Tax(12.00%)',
                                '₹216',
                                isTotal: false,
                              ),
                              _buildPriceRow(
                                'Shipping',
                                'Free',
                                isTotal: false,
                                valueColor: Colors.green.shade600,
                              ),

                              SizedBox(height: Get.height / 50),
                              // Total Amount Row
                              _buildPriceRow(
                                'Total',
                                '₹2,016.00',
                                isTotal: true,
                              ), // Example total
                            ],
                          ),
                        ),
                        SizedBox(height: Get.height / 50),
                        Text(
                          'Actions',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: Get.width / 22.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height / 50),

                        SizedBox(
                          width: double.infinity,
                          height: Get.height / 18,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff4F6B1F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Mark as Confirmed",
                              style: GoogleFonts.poppins(
                                fontSize: Get.width / 22.5,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height / 90),
                        SizedBox(
                          width: double.infinity,
                          height: Get.height / 18,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffE83C4B),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Mark as Confirmed",
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
                ],
              ),
            ),
          ),
          SizedBox(height: Get.height / 20),
        ],
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
                textStyle: TextStyle(
                  fontSize: Get.width / 30,
                  color: Colors.grey.shade800,
                ),
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
              textStyle: TextStyle(
                fontSize: Get.width / 30,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: Get.width / 30,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemRow(String name, String quantityDetails, String price) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: Get.width / 22.5,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: Get.height / 200),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
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
                  fontSize: Get.width / 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
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

  Widget _buildItemTable({required List<Map<String, String>> items}) {
    // Define the base style for all item details
    final TextStyle baseStyle = GoogleFonts.poppins(
      textStyle: TextStyle(
        fontSize: Get.width / 30,
        color: Colors.grey.shade700,
      ),
    );

    // Header Row with 5 columns
    Widget buildHeaderRow() {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Row(
          children: [
            // Flex distribution adjusted for mobile screen size
            Expanded(
              flex: 4,
              child: Text(
                'Product',
                style: baseStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: Get.width / 28,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'Net Wt.',
                textAlign: TextAlign.center,
                style: baseStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: Get.width / 28,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'Price',
                textAlign: TextAlign.right,
                style: baseStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: Get.width / 28,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Qty',
                textAlign: TextAlign.center,
                style: baseStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: Get.width / 28,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'Total',
                textAlign: TextAlign.right,
                style: baseStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: Get.width / 28,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Single Item Data Row
    Widget buildItemRow(Map<String, String> item) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Text(
                item['name']!,
                style: baseStyle.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                item['netWt']!,
                textAlign: TextAlign.center,
                style: baseStyle,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                item['price']!,
                textAlign: TextAlign.right,
                style: baseStyle,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                item['qty']!,
                textAlign: TextAlign.center,
                style: baseStyle,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                item['total']!,
                textAlign: TextAlign.right,
                style: baseStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Table Title
        Text(
          'Items',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: Get.width / 22.5,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: Get.height / 100),

        // Header and separator
        buildHeaderRow(),
        const Divider(thickness: 1, height: 1),
        const SizedBox(height: 5),

        // Item Rows
        ...items.map((item) => buildItemRow(item)).toList(),
      ],
    );
  }
}

class InvoiceActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const InvoiceActionButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: mainOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: Get.width / 22.5,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}

class OutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const OutlineButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = mainOrange,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(color: color, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: Get.width / 22.5,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
