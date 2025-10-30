import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/model/all_orders_model/all_orders_model.dart';
import 'package:intl/intl.dart';

const Color mainOrange = Color(0xffF78520);

class AllOrdersDetailScreen extends StatelessWidget {
  const AllOrdersDetailScreen({super.key});

  // 🔹 Format date safely
  String _formatDate(dynamic date) {
    if (date == null) return '-';
    try {
      if (date is DateTime) {
        return DateFormat('dd MMM yyyy, hh:mm a').format(date);
      } else if (date is String) {
        final parsed = DateTime.tryParse(date);
        if (parsed != null) {
          return DateFormat('dd MMM yyyy, hh:mm a').format(parsed);
        }
      }
    } catch (_) {}
    return '-';
  }

  // 🔹 Convert to double safely
  double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final AllOrdersModel order = Get.arguments;

    // 🧾 Build item list using order.products
    final items = (order.products).map<Map<String, dynamic>>((product) {
      final double price = _toDouble(product.price);
      final double qty = _toDouble(product.quantity);
      final double total = _toDouble(product.subtotal);

      return {
        'name': product.productName,
        'netWt': '${product.netWeight}g',
        'price': price,
        'qty': qty,
        'total': total,
      };
    }).toList();

    // 🧮 Calculate totals
    final double subtotal = items.fold(0, (sum, i) => sum + (i['total'] ?? 0));
    final double tax = subtotal * 0.12;
    final double total = subtotal + tax;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          SizedBox(height: Get.height / 30),

          // --- AppBar Section ---
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
                      icon: const Icon(Icons.arrow_back, color: mainOrange),
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
                        // --- Order Header ---
                        Text(
                          'Order #${order.orderNumber}',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: Get.width / 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height / 70),

                        // --- Customer Info ---
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
                                order.customerName,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: Get.width / 30,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height / 70),
                              _buildIconText(Icons.call, order.customerMobile),
                              _buildIconText(
                                Icons.location_on,
                                order.customerAddress,
                              ),
                            ],
                          ),
                        ),

                        // --- Order Info ---
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
                              _buildDetailRow(
                                'Amount:',
                                '₹${subtotal.toStringAsFixed(2)}',
                              ),
                              _buildDetailRow('Status:', order.status),
                              _buildDetailRow('Payment:', order.paymentStatus),
                              _buildDetailRow('Method:', order.paymentMethod),
                              _buildDetailRow(
                                'Created:',
                                _formatDate(order.createdAt),
                              ),
                              _buildDetailRow(
                                'Updated:',
                                _formatDate(order.updatedAt),
                              ),
                            ],
                          ),
                        ),

                        // --- Items Table ---
                        CustomInvoiceCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildItemTable(items: items),
                              const Divider(height: 30, thickness: 1),

                              // --- Price Summary ---
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
                              SizedBox(height: Get.height / 50),
                              _buildPriceRow(
                                'Total',
                                '₹${total.toStringAsFixed(2)}',
                                isTotal: true,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: Get.height / 50),

                        // --- Actions ---
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

                        _buildActionButton(
                          label: "Mark as Confirmed",
                          color: const Color(0xff4F6B1F),
                          onTap: () {
                            // confirm order API here
                          },
                        ),
                        SizedBox(height: Get.height / 90),
                        _buildActionButton(
                          label: "Mark as Cancelled",
                          color: const Color(0xffE83C4B),
                          onTap: () {
                            // cancel order API here
                          },
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

  // ----------------- REUSABLE WIDGETS -----------------

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
              fontSize: isTotal ? Get.width / 26 : Get.width / 30,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : Colors.grey.shade700,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: isTotal ? Get.width / 26 : Get.width / 30,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: valueColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemTable({required List<Map<String, dynamic>> items}) {
    final TextStyle baseStyle = GoogleFonts.poppins(
      textStyle: TextStyle(
        fontSize: Get.width / 30,
        color: Colors.grey.shade700,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Items',
          style: GoogleFonts.poppins(
            fontSize: Get.width / 22.5,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: const [
            Expanded(flex: 4, child: Text('Product')),
            Expanded(flex: 2, child: Center(child: Text('Net Wt.'))),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text('Price'),
              ),
            ),
            Expanded(flex: 1, child: Center(child: Text('Qty'))),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text('Total'),
              ),
            ),
          ],
        ),
        const Divider(thickness: 1),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Row(
              children: [
                Expanded(flex: 4, child: Text(item['name'], style: baseStyle)),
                Expanded(
                  flex: 2,
                  child: Center(child: Text(item['netWt'], style: baseStyle)),
                ),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '₹${item['price'].toStringAsFixed(2)}',
                      style: baseStyle,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text('${item['qty']}', style: baseStyle),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '₹${item['total'].toStringAsFixed(2)}',
                      style: baseStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: Get.height / 18,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onTap,
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: Get.width / 22.5,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// 🔹 Card Wrapper Widget
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
