import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/view/component/textfield.dart';

import '../../../../model/b2b_order/b2b_order_model.dart';
import '../../../../routes/routes.dart';

class OrderDetailScreen extends StatelessWidget {
  final B2BOrder order; // ✅ get data from API model
  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    double subTotal = 0;
    if (order.items.isNotEmpty) {
      subTotal = order.items.fold<double>(
        0,
        (sum, item) => sum + double.tryParse(item.total)!.toDouble(),
      );
    } else {
      subTotal = double.tryParse(order.totalAmount)?.toDouble() ?? 0;
    }
    final tax = subTotal * 0.12;
    final total = subTotal + tax;
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
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
                    Expanded(
                      child: Center(
                        child: Text(
                          'Order Detail',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: Get.width / 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width / 15),
                  ],
                ),
              ],
            ),
          ),

          // 🔹 Scroll Section
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
                    // 🔸 Top Tabs
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _topTab('Edit', false),
                        _topTab('Delete', false),
                        _topTab('Share', false),
                        _topTab('Print', false),
                      ],
                    ),
                    SizedBox(height: height / 40),

                    // 🔸 Order Information
                    _sectionTitle('Order Information'),
                    CustomTextField(
                      hint: order.orderNo,
                      label: 'Order Number',
                      isReadOnly: true,
                    ),
                    SizedBox(height: height / 60),

                    CustomTextField(
                      hint: order.createdAt,
                      label: 'Order Date',
                      isReadOnly: true,
                    ),
                    SizedBox(height: height / 60),

                    CustomDropdownField(
                      label: 'Status',
                      items: ['Pending', 'Approved', 'Rejected'],
                      value: order.status,
                      getLabel: (val) => val.toString(),
                      onChanged: (val) {},
                      hint: order.status,
                    ),
                    SizedBox(height: height / 60),

                    CustomDropdownField(
                      label: 'Payment',
                      items: ['Pending', 'Approved', 'Rejected'],
                      value: order.paymentStatus,
                      getLabel: (val) => val.toString(),
                      onChanged: (val) {},
                      hint: order.paymentStatus,
                    ),
                    SizedBox(height: height / 60),

                    CustomTextField(
                      hint: '₹${order.totalAmount}',
                      label: 'Total Amount',
                      isReadOnly: true,
                    ),
                    SizedBox(height: height / 60),

                    _outlinedButton('View Invoice', () {
                      Get.toNamed(Routes.invoice);
                    }),
                    SizedBox(height: height / 40),

                    // 🔸 Customer Information
                    _sectionTitle('Customer Information'),
                    CustomTextField(
                      hint: order.customerName,
                      label: 'Name',
                      isReadOnly: true,
                    ),
                    SizedBox(height: height / 60),

                    CustomTextField(
                      hint: order.customerEmail,
                      label: 'Email',
                      isReadOnly: true,
                    ),
                    SizedBox(height: height / 60),

                    CustomTextField(
                      hint: order.customerPhone,
                      label: 'Phone',
                      isReadOnly: true,
                    ),
                    SizedBox(height: height / 60),

                    CustomTextField(
                      hint: order.customerCompany.isEmpty
                          ? '-'
                          : order.customerCompany,
                      label: 'Company',
                      isReadOnly: true,
                    ),
                    SizedBox(height: height / 60),

                    CustomTextField(
                      hint: order.customerAddress.isEmpty
                          ? '-'
                          : order.customerAddress,
                      label: 'Address',
                      isReadOnly: true,
                    ),
                    SizedBox(height: height / 60),

                    CustomTextField(
                      hint: order.customerGst.isEmpty ? '-' : order.customerGst,
                      label: 'GST',
                      isReadOnly: true,
                    ),
                    SizedBox(height: height / 40),

                    // 🔸 Order Items (placeholder for now)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _sectionTitle('Order Items'),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Edit',
                            style: GoogleFonts.poppins(color: Colors.orange),
                          ),
                        ),
                      ],
                    ),
                    if (order.items.isNotEmpty)
                      ...order.items.map(
                        (item) => Column(
                          children: [
                            _orderItem('Product', item.productName),
                            _orderItem('Price', '₹${item.price}'),
                            _orderItem('Varients', item.variationValue),
                            _orderItem('QTY', item.quantity),
                            const Divider(),
                          ],
                        ),
                      )
                    else
                      // fallback static items
                      Column(
                        children: [
                          _orderItem('Product', 'Farani Petis'),
                          _orderItem('Price', '₹200'),
                          _orderItem('Varients', '-'),
                          _orderItem('QTY', '1'),
                          const Divider(),
                          _orderItem('Product', 'Mohanthal'),
                          _orderItem('Price', '₹100'),
                          _orderItem('Varients', '500gm'),
                          _orderItem('QTY', '1'),
                          const Divider(),
                        ],
                      ),

                    // 🔹 Subtotal / Tax / Total
                    _subTotal('Subtotal', '₹${subTotal.toStringAsFixed(2)}'),
                    _subTotal('Tax Rate(12.00%)', '₹${tax.toStringAsFixed(2)}'),
                    _subTotal(
                      'Total(Incl.Tax)',
                      '₹${total.toStringAsFixed(2)}',
                    ),
                    SizedBox(height: height / 40),

                    // 🔸 Quick Actions
                    _sectionTitle('Quick Actions'),
                    CustomDropdownField(
                      label: 'Order Status',
                      items: ['Pending', 'Approved', 'Rejected'],
                      value: order.status,
                      getLabel: (val) => val.toString(),
                      onChanged: (val) {},
                      hint: order.status,
                    ),
                    SizedBox(height: height / 60),

                    CustomDropdownField(
                      label: 'Payment Status',
                      items: ['Pending', 'Approved', 'Rejected'],
                      value: order.paymentStatus,
                      getLabel: (val) => val.toString(),
                      onChanged: (val) {},
                      hint: order.paymentStatus,
                    ),
                    SizedBox(height: height / 30),

                    SizedBox(
                      height: Get.height / 18,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.createNewb2bOrder);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffF78520),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Create Manual Order',
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
            ),
          ),
          SizedBox(height: height / 20),
        ],
      ),
    );
  }

  // 🔹 Helper Widgets
  Widget _topTab(String text, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? Colors.orange : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: Get.width / 32.5,
          color: isActive ? Colors.white : Colors.orange,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: Get.width / 20,
          fontWeight: FontWeight.w700,
          color: const Color(0xffF78520),
        ),
      ),
    );
  }

  Widget _outlinedButton(String text, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xffF78520),
          side: const BorderSide(color: Color(0xffF78520)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _orderItem(String title, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: Get.width / 26,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            price,
            style: GoogleFonts.poppins(
              fontSize: Get.width / 26,
              fontWeight: FontWeight.w500,
              color: const Color(0xff5D686E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _subTotal(String title, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: Get.width / 26,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            price,
            style: GoogleFonts.poppins(
              fontSize: Get.width / 26,
              fontWeight: FontWeight.w600,
              color: const Color(0xff5D686E),
            ),
          ),
        ],
      ),
    );
  }
}
