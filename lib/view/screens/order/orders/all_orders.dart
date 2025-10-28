import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/main.dart';
import 'package:har_bhole/routes/routes.dart';

import '../../../../model/orders_model/orders_model.dart';
import '../../../component/textfield.dart';

class AllOrders extends StatelessWidget {
  const AllOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (allOrdersController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xffF78520)),
                );
              }

              return SingleChildScrollView(
                padding: EdgeInsets.all(Get.width / 30),
                child: Column(
                  children: [
                    // Single order container for current page orders
                    ...allOrdersController.paginatedOrders
                        .map(
                          (order) =>
                              _buildOrderContainer(order, allOrdersController),
                        )
                        .toList(),

                    SizedBox(height: Get.height / 20),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderContainer(Order order, allOrdersController) {
    return Container(
      margin: EdgeInsets.only(bottom: Get.height / 40),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'All Order(Latest)',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: Get.width / 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Get.height / 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomTextField(
                  hint: "Search",
                  icon: Icons.search,
                  onChanged: (value) => allOrdersController.searchOrders(value),
                ),
              ),
              SizedBox(width: Get.width / 90),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // View action
                    },
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffF78520)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Export CSV',
                        style: TextStyle(
                          color: Color(0xffF78520),
                          fontWeight: FontWeight.bold,
                          fontSize: Get.width / 36,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Get.width / 100),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffF78520)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        color: Color(0xffF78520),
                        fontWeight: FontWeight.bold,
                        fontSize: Get.width / 36,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Get.height / 50),
          CustomTextField(
            label: 'Order',
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
            label: 'Location',
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
            hint: _capitalizeFirstLetter(order.status),
            isReadOnly: true,
          ),
          SizedBox(height: Get.height / 60),
          CustomTextField(
            label: 'Payment',
            hint: _capitalizeFirstLetter(order.paymentStatus),
            isReadOnly: true,
          ),
          SizedBox(height: Get.height / 60),
          CustomTextField(
            label: 'Date',
            hint: _formatDate(order.createdAt),
            isReadOnly: true,
          ),
          SizedBox(height: Get.height / 60),
          _buildPagination(allOrdersController),
          SizedBox(height: Get.height / 60),
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
              onPressed: () {
                // Pass the order data to detail screen
                Get.toNamed(Routes.allOrdersDetailScreen, arguments: order);
              },
              child: Text(
                "View",
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
    );
  }

  Widget _buildOrderNumberField(Order order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order',
          style: TextStyle(
            fontSize: Get.width / 26,
            fontWeight: FontWeight.w500,
            color: Color(0xff000000),
          ),
        ),
        SizedBox(height: Get.height / 150),
        Container(
          height: Get.height / 20,
          padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
          decoration: BoxDecoration(
            color: const Color(0xffF3F7FC),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.orderNumber,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: Get.width / 30,
                  ),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xff858585),
                size: 20,
              ),
            ],
          ),
        ),
        SizedBox(height: Get.height / 50),
      ],
    );
  }

  Widget _buildPagination(allOrdersController) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height / 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Previous page button
          GestureDetector(
            onTap: allOrdersController.prevPage,
            child: Container(
              width: Get.width / 13,
              height: Get.width / 13,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffFAF7F6),
              ),
              child: const Icon(
                Icons.keyboard_double_arrow_left,
                size: 19,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(width: Get.width / 40),

          // Page 1
          GestureDetector(
            onTap: () => allOrdersController.updatePagination(page: 1),
            child: Container(
              width: Get.width / 13,
              height: Get.width / 13,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: allOrdersController.page.value == 1
                    ? Color(0xffF78520)
                    : Color(0xffFAF7F6),
                shape: BoxShape.circle,
              ),
              child: Text(
                '1',
                style: GoogleFonts.poppins(
                  color: allOrdersController.page.value == 1
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: Get.width / 30,
                ),
              ),
            ),
          ),
          SizedBox(width: Get.width / 40),

          // Page 2
          GestureDetector(
            onTap: () => allOrdersController.updatePagination(page: 2),
            child: Container(
              width: Get.width / 13,
              height: Get.width / 13,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: allOrdersController.page.value == 2
                    ? Color(0xffF78520)
                    : Color(0xffFAF7F6),
                shape: BoxShape.circle,
              ),
              child: Text(
                '2',
                style: GoogleFonts.poppins(
                  color: allOrdersController.page.value == 2
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: Get.width / 30,
                ),
              ),
            ),
          ),
          SizedBox(width: Get.width / 40),

          // Next page button
          GestureDetector(
            onTap: allOrdersController.nextPage,
            child: Container(
              width: Get.width / 13,
              height: Get.width / 13,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffFAF7F6),
              ),
              child: const Icon(
                Icons.keyboard_double_arrow_right,
                size: 19,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${_getMonthName(date.month)} ${date.day}, ${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')} ${date.hour < 12 ? 'AM' : 'PM'}';
    } catch (e) {
      return dateString;
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
    return months[month - 1];
  }
}
