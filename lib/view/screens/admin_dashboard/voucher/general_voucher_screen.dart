import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/routes/routes.dart';
import 'package:har_bhole/view/component/textfield.dart';

import '../../../../main.dart';
import '../../../../model/voucher_model/voucher_model.dart';

class GeneralVouchersScreen extends StatelessWidget {
  const GeneralVouchersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color mainOrange = Color(0xffF78520);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: Get.height / 25,
                left: Get.width / 25,
                right: Get.width / 25,
                bottom: Get.height / 50,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  colors: [Color(0xffFFE1C7), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 1.0],
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'General Vouchers',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: Get.width / 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height / 200),
                          Text(
                            'Manage all General Vouchers',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: Get.width / 28,
                                color: Color(0xff4A4541),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height / 50),
                  SizedBox(
                    height: Get.height / 18,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Routes.addVoucherScreen);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffF78520),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        '+ Add Voucher',
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
            Expanded(
              child: Container(
                color: Colors.grey.shade200,
                padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
                child: Column(
                  children: [
                    SizedBox(height: Get.height / 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'General Vouchers',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: Get.width / 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'View All',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: Get.width / 26,
                                fontWeight: FontWeight.w500,
                                color: mainOrange,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height / 50),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(Get.width / 28),
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
                          children: [
                            CustomTextField(
                              hint: "Reference / Description",
                              icon: Icons.search,
                              onChanged: (val) {
                                vouchersController.searchVouchers(val);
                              },
                            ),
                            SizedBox(height: Get.height / 50),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildFilterField(
                                  label: "Type",
                                  child: _buildFilterDropdown(label: "All"),
                                ),
                                _buildFilterField(
                                  label: "Status",
                                  child: _buildFilterDropdown(label: "All"),
                                ),
                                _buildFilterField(
                                  label: "From",
                                  child: _buildDateFilter(date: "25/09/2024"),
                                ),
                                _buildFilterField(
                                  label: "To",
                                  child: _buildDateFilter(date: "25/09/2024"),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Obx(() {
                                if (vouchersController.isLoading.value) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (vouchersController
                                    .filteredVouchers
                                    .isEmpty) {
                                  return Center(
                                    child: Text(
                                      vouchersController
                                              .errorMessage
                                              .value
                                              .isEmpty
                                          ? "No vouchers found"
                                          : vouchersController
                                                .errorMessage
                                                .value,
                                    ),
                                  );
                                } else {
                                  return ListView.builder(
                                    itemCount: vouchersController
                                        .filteredVouchers
                                        .length,
                                    itemBuilder: (context, index) {
                                      final v = vouchersController
                                          .filteredVouchers[index];
                                      return voucherRow(
                                        voucher: v,
                                        onViewDetails: () {
                                          Get.toNamed(
                                            Routes.viewVouchers,
                                            arguments: v,
                                          ); // pass voucher if needed
                                        },
                                      );
                                    },
                                  );
                                }
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget voucherRow({
    required Voucher voucher,
    required VoidCallback onViewDetails,
  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(Get.height / 80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left Column: Voucher info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    voucher.voucherCode ?? voucher.voucherNo ?? '-',
                    style: TextStyle(
                      fontSize: Get.width / 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Amount: ₹${voucher.amount}",
                    style: TextStyle(
                      fontSize: Get.width / 28,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),

              // Right Column: Status & Details
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: (voucher.status?.toLowerCase() == "approved")
                          ? const Color(0xffDCE1D7)
                          : Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      voucher.status ?? '',
                      style: TextStyle(
                        fontSize: Get.width / 33,
                        color: (voucher.status?.toLowerCase() == "approved")
                            ? const Color(0xff4E6B37)
                            : Colors.orange,
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height / 200),
                  GestureDetector(
                    onTap: onViewDetails,
                    child: Text(
                      "View Details",
                      style: TextStyle(
                        fontSize: Get.width / 30,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: Get.height / 50),
        const Divider(height: 1, color: Colors.grey),
      ],
    );
  }

  Widget _buildFilterDropdown({required String label}) {
    return Container(
      width: Get.width / 4.5,
      height: Get.height / 22,
      padding: EdgeInsets.symmetric(horizontal: Get.width / 50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: Get.width / 40,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildDateFilter({required String date}) {
    return Container(
      width: Get.width / 4.5,
      height: Get.height / 22,
      padding: EdgeInsets.symmetric(horizontal: Get.width / 50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        date,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: Get.width / 40,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterField({required String label, required Widget child}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: Get.width / 30,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 6),
          child,
        ],
      ),
    );
  }
}
