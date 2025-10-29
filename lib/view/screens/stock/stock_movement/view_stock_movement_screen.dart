import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../main.dart';
import '../../../component/textfield.dart';

class ViewStockMovementScreen extends StatelessWidget {
  const ViewStockMovementScreen({super.key});

  final Color mainOrange = const Color(0xffF78520);

  @override
  Widget build(BuildContext context) {
    // ✅ Get the selected movement passed via Get.arguments
    final movement = Get.arguments;

    // ✅ If no data passed
    if (movement == null) {
      return Scaffold(
        body: Center(
          child: Text(
            "No Stock Movement Data Found",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    }

    // ✅ Create controllers for the passed movement
    final dateController = TextEditingController(
      text: movement.createdAt ?? '',
    );
    final typeController = TextEditingController(
      text: movement.movementType ?? '',
    );
    final quantityController = TextEditingController(
      text: movement.quantity ?? '',
    );
    final stockTypeController = TextEditingController(
      text: movement.stockType ?? '',
    );
    final referenceController = TextEditingController(
      text: movement.referenceType ?? '',
    );
    final notesController = TextEditingController(text: movement.notes ?? '');

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Obx(() {
          // ✅ Show loading only if data still fetching
          if (stockMovementController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xffF78520)),
            );
          }

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
                      'Stock Movement',
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
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     _buildFilterField(
                        //       label: "Search",
                        //       child: _buildFilterDropdown(label: "Code/Name"),
                        //     ),
                        //     _buildFilterField(
                        //       label: "Category",
                        //       child: _buildFilterDropdown(
                        //         label: "All Category",
                        //       ),
                        //     ),
                        //     _buildFilterField(
                        //       label: "Unit",
                        //       child: _buildFilterDropdown(label: "All Units"),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(height: Get.height / 30),
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
                        SizedBox(
                          height: Get.height / 18,
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () async {
                              await Get.defaultDialog(
                                title: "Delete Stock Movement",
                                titleStyle: TextStyle(
                                  color: const Color(0xffF78520),
                                  fontWeight: FontWeight.bold,
                                  fontSize: Get.width / 20,
                                ),
                                backgroundColor: Colors.white,
                                radius: 20,
                                barrierDismissible: false,
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Get.width / 20,
                                    vertical: Get.height / 50,
                                  ),
                                  child: Text(
                                    "Are you sure you want to delete this stock movement?",
                                    style: TextStyle(
                                      color: const Color(0xffF78520),
                                      fontSize: Get.width / 30,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                textConfirm: "Yes",
                                textCancel: "No",
                                confirmTextColor: const Color(0xffF78520),
                                cancelTextColor: const Color(0xffF78520),
                                buttonColor: Colors.white,
                                onConfirm: () async {
                                  if (Get.isDialogOpen ?? false) Get.back();

                                  print(
                                    '🟠 Trying to delete Stock Movement ID: ${movement.stockId}',
                                  );

                                  await stockMovementController
                                      .deleteStockMovement(
                                        movement.movementId.toString(),
                                      );
                                },
                                onCancel: () {
                                  if (Get.isDialogOpen ?? false) Get.back();
                                },
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                color: Color(0xffF78520),
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Color(0xffF78520)),
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
}
