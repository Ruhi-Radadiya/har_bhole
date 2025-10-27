import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../main.dart';
import '../../../../routes/routes.dart';
import '../../../component/textfield.dart';

class StockMovementEntryScreen extends StatelessWidget {
  const StockMovementEntryScreen({super.key});

  final Color mainOrange = const Color(0xffF78520);

  @override
  Widget build(BuildContext context) {
    // Fetch data once when screen builds
    stockMovementController.fetchStockMovements();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Obx(() {
          // 🔹 Loading State
          if (stockMovementController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          // 🔹 Empty State
          if (stockMovementController.stockMovementList.isEmpty) {
            return const Center(
              child: Text(
                "No Stock Movement Found",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            );
          }

          // 🔹 Show last movement
          final lastMovement = stockMovementController.stockMovementList.last;

          final dateController = TextEditingController(
            text: lastMovement.createdAt ?? '',
          );
          final typeController = TextEditingController(
            text: lastMovement.movementType ?? '',
          );
          // final itemController =
          // TextEditingController(text: lastMovement.itemName ?? '');
          final quantityController = TextEditingController(
            text: lastMovement.quantity ?? '',
          );
          final stockTypeController = TextEditingController(
            text: lastMovement.stockType ?? '',
          );
          final referenceController = TextEditingController(
            text: lastMovement.referenceType ?? '',
          );
          final notesController = TextEditingController(
            text: lastMovement.notes ?? '',
          );

          return Column(
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

              // 🔹 Main Content
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
                        // 🔹 Status Chips Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildStatusChip(
                              'Total:',
                              '${stockMovementController.stockMovementList.length}',
                              const Color(0xffCCDBEF),
                              const Color(0xff004CAF),
                            ),
                            _buildStatusChip(
                              'Stock IN:',
                              stockMovementController.stockMovementList
                                  .where(
                                    (e) => e.movementType.toLowerCase() == 'in',
                                  )
                                  .length
                                  .toString(),
                              const Color(0xffDCE1D2),
                              const Color(0xff4F6B1F),
                            ),
                            _buildStatusChip(
                              'Stock Out:',
                              stockMovementController.stockMovementList
                                  .where(
                                    (e) =>
                                        e.movementType.toLowerCase() == 'out',
                                  )
                                  .length
                                  .toString(),
                              const Color(0xffEFCFD2),
                              const Color(0xffB52934),
                            ),
                            _buildStatusChip(
                              'Adjustments:',
                              stockMovementController.stockMovementList
                                  .where(
                                    (e) =>
                                        e.movementType.toLowerCase() ==
                                        'adjustment',
                                  )
                                  .length
                                  .toString(),
                              const Color(0xffFEEDD3),
                              const Color(0xffFAA423),
                            ),
                          ],
                        ),

                        SizedBox(height: Get.height / 30),

                        // 🔹 Filters Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildFilterField(
                              label: "Search",
                              child: _buildFilterDropdown(label: "Code/Name"),
                            ),
                            _buildFilterField(
                              label: "Category",
                              child: _buildFilterDropdown(
                                label: "All Category",
                              ),
                            ),
                            _buildFilterField(
                              label: "Unit",
                              child: _buildFilterDropdown(label: "All Units"),
                            ),
                          ],
                        ),

                        SizedBox(height: Get.height / 30),

                        // 🔹 Date Filters
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
                                isReadOnly: true,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: Get.height / 50),

                        // 🔹 Form Fields
                        CustomTextField(
                          hint: '',
                          label: 'Date & Time',
                          controller: dateController,
                          isReadOnly: true,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          hint: '',
                          label: 'Type',
                          controller: typeController,
                          isReadOnly: true,
                        ),
                        SizedBox(height: Get.height / 60),
                        // CustomTextField(
                        //   hint: '',
                        //   label: 'Item',
                        //   controller: itemController,
                        //   isReadOnly: true,
                        // ),
                        // SizedBox(height: Get.height / 60),
                        CustomTextField(
                          hint: '',
                          label: 'Quantity',
                          controller: quantityController,
                          isReadOnly: true,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          hint: '',
                          label: 'Stock Type',
                          controller: stockTypeController,
                          isReadOnly: true,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          hint: '',
                          label: 'Reference',
                          controller: referenceController,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          hint: '',
                          label: 'Notes',
                          controller: notesController,
                          maxLines: 2,
                        ),
                        SizedBox(height: Get.height / 60),

                        // 🔹 Buttons
                        SizedBox(
                          height: Get.height / 18,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed(Routes.addStockMovement);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mainOrange,
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
          );
        }),
      ),
    );
  }

  // 🔹 Helper Widgets

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
          const SizedBox(height: 6),
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
