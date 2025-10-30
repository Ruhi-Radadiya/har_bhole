import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../model/order_analytics_model/order_analytics_model.dart';
import '../../../../routes/routes.dart';
import '../../../component/textfield.dart';

class ViewOrderAnalytics extends StatelessWidget {
  const ViewOrderAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Receive the order data passed from previous screen
    final OrderAnalyticsModel order = Get.arguments as OrderAnalyticsModel;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          SizedBox(height: Get.height / 30),

          // 🔸 Header
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
                  'Order Analytics',
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

          // 🔸 Body
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(Get.width / 30),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(Get.width / 20),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Order Details',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: Get.width / 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height / 50),

                        // 🔸 Order Number
                        _buildReadOnlyField(
                          label: 'Order No.',
                          value: order.orderNumber,
                        ),

                        // 🔸 Customer
                        _buildReadOnlyField(
                          label: 'Customer Name',
                          value: order.customerName,
                        ),

                        // 🔸 Mobile
                        _buildReadOnlyField(
                          label: 'Mobile',
                          value: order.customerMobile,
                        ),

                        // 🔸 Amount
                        _buildReadOnlyField(
                          label: 'Total Amount',
                          value: "₹${order.totalAmount}",
                        ),

                        // 🔸 Status
                        _buildReadOnlyField(
                          label: 'Order Status',
                          value: order.status,
                        ),

                        // 🔸 Payment
                        _buildReadOnlyField(
                          label: 'Payment Status',
                          value: order.paymentStatus,
                        ),

                        // 🔸 Payment Method
                        _buildReadOnlyField(
                          label: 'Payment Method',
                          value: order.paymentMethod,
                        ),

                        // 🔸 Created At
                        _buildReadOnlyField(
                          label: 'Created On',
                          value: "${order.createdAt?.toLocal()}".split(
                            '.',
                          )[0], // formatted
                        ),
                        SizedBox(height: Get.height / 25),

                        // 🔸 View Invoice Button
                        SizedBox(
                          height: Get.height / 18,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed(
                                Routes.orderAnalyticsInvoice,
                                arguments: order,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF78520),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'View Invoice',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: Get.width / 22.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height / 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Reusable ReadOnly Field
  Widget _buildReadOnlyField({required String label, required String value}) {
    return Padding(
      padding: EdgeInsets.only(bottom: Get.height / 60),
      child: CustomTextField(label: label, hint: value, isReadOnly: true),
    );
  }
}
