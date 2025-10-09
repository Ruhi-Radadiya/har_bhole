import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../routes/routes.dart';
import '../../../component/textfield.dart';

class StockMovementEntryScreen extends StatelessWidget {
  const StockMovementEntryScreen({super.key});

  final Color mainOrange = const Color(0xffF78520);
  final Color stockInGreen = const Color(0xff4CAF50);
  final Color stockOutRed = const Color(0xffFF3B30);
  final Color adjustmentYellow = const Color(0xffFFC107);
  final Color inactiveGray = const Color(0xffD9D9D9);

  @override
  Widget build(BuildContext context) {
    final dateController = TextEditingController();
    final typeController = TextEditingController();
    final itemController = TextEditingController();
    final quantityController = TextEditingController();
    final stockTypeController = TextEditingController();
    final referenceController = TextEditingController();
    final notesController = TextEditingController();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
              child: SingleChildScrollView(
                padding: EdgeInsets.all(Get.width / 30),
                child: Container(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildStatusChip(
                            'Total:',
                            '91',
                            Color(0xffCCDBEF),
                            Color(0xff004CAF),
                          ),
                          _buildStatusChip(
                            'Stock IN:',
                            '43',
                            Color(0xffDCE1D2),
                            Color(0xff4F6B1F),
                          ),
                          _buildStatusChip(
                            'Stock Out:',
                            '43',
                            Color(0xffEFCFD2),
                            Color(0xffB52934),
                          ),
                          _buildStatusChip(
                            'Adjustments:',
                            '5',
                            Color(0xffFEEDD3),
                            Color(0xffFAA423),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height / 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildFilterField(
                            label: "Search",
                            child: _buildFilterDropdown(label: "Code/Name"),
                          ),
                          _buildFilterField(
                            label: "Category",
                            child: _buildFilterDropdown(label: "All Category"),
                          ),
                          _buildFilterField(
                            label: "Unit",
                            child: _buildFilterDropdown(label: "All Units"),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height / 30),

                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: 'From',
                              hint: '20/09/2024',
                              isReadOnly: true,
                            ),
                          ),
                          SizedBox(width: Get.width / 30),
                          Expanded(
                            child: CustomTextField(
                              label: 'To',
                              hint: '20/09/2024',
                              isReadOnly: true, // For date picker functionality
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height / 50),
                      CustomTextField(
                        label: 'Date & Time',
                        hint: '24 sep, 2025, 15:18',
                        controller: dateController,
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Type',
                        hint: 'IN',
                        controller: typeController,
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Item',
                        hint: 'ID: 16(raw)',
                        controller: itemController,
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Quantity',
                        hint: '2.00 Unit',
                        controller: quantityController,
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Stock Type',
                        hint: 'Raw Material',
                        controller: stockTypeController,
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Reference',
                        hint: 'ADJUSTMENT',
                        controller: referenceController,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Notes',
                        hint: 'Initial stock entry',
                        controller: notesController,
                        maxLines: 2,
                      ),
                      SizedBox(height: Get.height / 60),
                      SizedBox(
                        height: Get.height / 18,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed(Routes.addStockMovement);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffF78520),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            '+ Add Movement',
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
                      SizedBox(height: Get.height / 80),
                      SizedBox(
                        height: Get.height / 18,
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                              color: Color(0xffF78520),
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Delete',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: Get.width / 22.5,
                                color: mainOrange,
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
            SizedBox(height: Get.height / 20),
          ],
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
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: Get.width / 30,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 6),
          child,
        ],
      ),
    );
  }

  Widget _buildFilterDropdown({required String label}) {
    return Container(
      width: Get.width / 3.8,
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

  Widget _buildStatusChip(
    String label,
    String count,
    Color color,
    Color textColor,
  ) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Get.width / 190),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: Get.width / 42,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ),
            Text(
              count,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: Get.width / 40,
                  fontWeight: FontWeight.w800,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
