import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/main.dart';

import '../../../../routes/routes.dart';
import '../../../component/textfield.dart';
import 'order_detail_screen.dart';

class B2BOrderScreen extends StatelessWidget {
  const B2BOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color mainOrange = Color(0xffF78520);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top Header
          Container(
            padding: EdgeInsets.only(
              top: Get.height / 25,
              left: Get.width / 25,
              right: Get.width / 25,
              bottom: Get.height / 50,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffFFE1C7), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height / 100),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: Color(0xffFAD6B5),
                        shape: BoxShape.circle,
                      ),
                      child: SizedBox(
                        height: Get.width / 15,
                        width: Get.width / 15,
                        child: Image.asset('asset/icons/users_icon.png'),
                      ),
                    ),
                    SizedBox(width: Get.width / 30),
                    Text(
                      'B2B Order',
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
                SizedBox(height: Get.height / 50),
                SizedBox(
                  height: Get.height / 18,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.createNewb2bOrder);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Add B2B Order',
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

          SizedBox(height: Get.height / 50),

          // Search & Filter
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Get.width / 40),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CustomTextField(
                      icon: Icons.search,
                      hint: "Search by Customer...",
                      onChanged: b2bOrderController.searchOrder,
                    ),
                  ),
                ),
                SizedBox(width: Get.width / 40),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width / 40,
                    vertical: Get.height / 200,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "All Status",
                        style: GoogleFonts.poppins(
                          fontSize: Get.width / 26,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: Get.height / 50),

          // Orders List
          Expanded(
            child: Obx(() {
              if (b2bOrderController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xffF78520)),
                );
              }
              if (b2bOrderController.filteredOrders.isEmpty) {
                return const Center(child: Text("No orders found"));
              }
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                itemCount: b2bOrderController.filteredOrders.length,
                itemBuilder: (context, index) {
                  final order = b2bOrderController.filteredOrders[index];
                  return _buildOrderTile(order);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTile(order) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: Get.height / 100),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: Get.width / 16,
                backgroundImage: const AssetImage(
                  'asset/images/person_image.jpg',
                ),
                backgroundColor: Colors.grey.shade200,
              ),
              SizedBox(width: Get.width / 25),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.customerName,
                      style: GoogleFonts.poppins(
                        fontSize: Get.width / 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: Get.height / 200),
                    Text(
                      order.customerEmail,
                      style: GoogleFonts.poppins(
                        fontSize: Get.width / 30,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: Get.height / 250),
                    Text(
                      order.customerPhone,
                      style: GoogleFonts.poppins(
                        fontSize: Get.width / 30,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width / 40,
                      vertical: Get.height / 200,
                    ),
                    decoration: BoxDecoration(
                      color: order.status.toLowerCase() == "delivered"
                          ? const Color(0xffDCE1D7)
                          : const Color(0xffEFCFD2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      order.status,
                      style: GoogleFonts.poppins(
                        fontSize: Get.width / 36,
                        fontWeight: FontWeight.bold,
                        color: order.status.toLowerCase() == "delivered"
                            ? const Color(0xff4E6B37)
                            : const Color(0xffAD111E),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height / 120),
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        () => OrderDetailScreen(order: order),
                        arguments: order,
                      );
                    },
                    child: Text(
                      'View Details',
                      style: GoogleFonts.poppins(
                        fontSize: Get.width / 36,
                        color: const Color(0xff2A86D1),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(height: Get.height / 200, color: Colors.grey.shade300),
      ],
    );
  }
}
