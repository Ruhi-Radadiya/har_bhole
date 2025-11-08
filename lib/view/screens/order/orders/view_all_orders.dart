import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/routes/routes.dart';

import '../../../../model/all_orders_model/all_orders_model.dart';
import '../../../component/textfield.dart';

class ViewAllOrders extends StatelessWidget {
  const ViewAllOrders({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Retrieve order object from navigation arguments
    final AllOrdersModel order = Get.arguments;

    const Color mainOrange = Color(0xffF78520);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Get.width / 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height / 30),
            // 🔹 Header
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
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xffF78520),
                    ),
                    onPressed: () => Get.back(),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(minWidth: Get.width / 15),
                  ),
                  SizedBox(width: Get.width / 100),
                  Text(
                    'Order Details',
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

            SizedBox(height: Get.height / 40),

            // 🧾 Order Info Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(Get.width / 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    label: 'Order Number',
                    hint: order.orderNumber,
                    isReadOnly: true,
                  ),
                  SizedBox(height: Get.height / 60),

                  CustomTextField(
                    label: 'Customer',
                    hint: order.customerName,
                    isReadOnly: true,
                  ),
                  SizedBox(height: Get.height / 60),

                  CustomTextField(
                    label: 'Mobile',
                    hint: order.customerMobile,
                    isReadOnly: true,
                  ),
                  SizedBox(height: Get.height / 60),

                  CustomTextField(
                    label: 'Address',
                    hint: order.customerAddress,
                    isReadOnly: true,
                  ),
                  SizedBox(height: Get.height / 60),

                  CustomTextField(
                    label: 'Amount',
                    hint: '₹${order.totalAmount}',
                    isReadOnly: true,
                  ),
                  SizedBox(height: Get.height / 60),

                  CustomTextField(
                    label: 'Status',
                    hint: _capitalize(order.status),
                    isReadOnly: true,
                  ),
                  SizedBox(height: Get.height / 60),

                  CustomTextField(
                    label: 'Payment Status',
                    hint: _capitalize(order.paymentStatus),
                    isReadOnly: true,
                  ),
                  SizedBox(height: Get.height / 60),

                  CustomTextField(
                    label: 'Payment Method',
                    hint: order.paymentMethod,
                    isReadOnly: true,
                  ),
                  SizedBox(height: Get.height / 60),

                  CustomTextField(
                    label: 'Date',
                    hint: _formatDate(order.createdAt),
                    isReadOnly: true,
                  ),

                  SizedBox(height: Get.height / 25),

                  // 🔸 View More Button
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
                      onPressed: () {
                        Get.toNamed(
                          Routes.allOrdersDetailScreen,
                          arguments: order,
                        );
                      },
                      child: Text(
                        "View Full Details",
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
            SizedBox(height: Get.height / 25),
          ],
        ),
      ),
    );
  }

  // --- Helper Functions ---

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  /// ✅ Fix: Handles both String and DateTime safely
  String _formatDate(dynamic dateValue) {
    try {
      if (dateValue == null) return '-';

      late DateTime date;

      if (dateValue is DateTime) {
        date = dateValue;
      } else if (dateValue is String && dateValue.isNotEmpty) {
        date = DateTime.tryParse(dateValue) ?? DateTime.now();
      } else {
        return '-';
      }

      final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
      final amPm = date.hour < 12 ? 'AM' : 'PM';

      return '${_getMonthName(date.month)} ${date.day}, ${date.year} $hour:${date.minute.toString().padLeft(2, '0')} $amPm';
    } catch (e) {
      return '-';
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[(month - 1).clamp(0, 11)];
  }
}
