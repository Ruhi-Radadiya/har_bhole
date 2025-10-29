import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/model/semi_finished_material_model/semi_finished_material_model.dart';

import '../../../../main.dart';
import '../../../component/textfield.dart';

class ViewAllSemiFinishedMaterial extends StatelessWidget {
  const ViewAllSemiFinishedMaterial({super.key});
  final Color mainOrange = const Color(0xffF78520);
  final Color inStockGreen = const Color(0xff4F6B1F);
  final Color lowStockYellow = const Color(0xffFFC107);
  final Color outOfStockRed = const Color(0xffFF3B30);

  @override
  Widget build(BuildContext context) {
    final SemiFinishedMaterialModel item = Get.arguments;
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
                  'Semi Finished Material',
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
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Semi-Finished Materials',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: Get.width / 22.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffF78520),
                            ),
                          ),
                        ),
                        // SizedBox(height: Get.height / 50),
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
                        SizedBox(height: Get.height / 50),
                        Column(
                          children: [
                            CustomTextField(
                              label: 'Code',
                              hint: item.itemCode,
                              isReadOnly: true,
                            ),
                            SizedBox(height: Get.height / 60),
                            CustomTextField(
                              label: 'Name',
                              hint: item.itemName,
                              isReadOnly: true,
                            ),
                            SizedBox(height: Get.height / 60),
                            CustomTextField(
                              label: 'Category',
                              hint: item.categoryId,
                              isReadOnly: true,
                            ),
                            SizedBox(height: Get.height / 60),
                            CustomTextField(
                              label: 'BOM',
                              hint: '${item.bomItems.length.toString()} items',
                              isReadOnly: true,
                            ),
                            SizedBox(height: Get.height / 60),
                            CustomTextField(
                              label: 'Current Stock',
                              hint:
                                  '${item.currentQuantity} ${item.unitOfMeasure}',
                              isReadOnly: true,
                            ),
                            SizedBox(height: Get.height / 60),
                            CustomTextField(
                              label: 'Unit',
                              hint: item.unitOfMeasure,
                              isReadOnly: true,
                            ),
                            SizedBox(height: Get.height / 60),
                            CustomTextField(
                              label: 'Output Type',
                              hint: item.outputType,
                              isReadOnly: true,
                            ),
                            SizedBox(height: Get.height / 60),
                            CustomTextField(
                              label: 'Box Weight (kg)',
                              hint: item.boxWeight,
                              isReadOnly: true,
                            ),
                            SizedBox(height: Get.height / 60),
                            CustomTextField(
                              label: 'Box Dimensions',
                              hint: item.boxDimensions,
                              isReadOnly: true,
                            ),
                            SizedBox(height: Get.height / 50),
                            SizedBox(
                              height: Get.height / 18,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffF78520),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  'Edit',
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
                            SizedBox(height: Get.height / 50),
                            SizedBox(
                              height: Get.height / 18,
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () async {
                                  await Get.defaultDialog(
                                    title: "Delete Raw Material",
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
                                        "Are you sure you want to delete this raw material?",
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
                                        '🟠 Trying to delete Stock ID: ${item.stockId}',
                                      );

                                      await semiFinishedController
                                          .deleteSemiFinishedMaterial(
                                            item.stockId.toString(),
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

  Widget _buildFilterDropdown({required String label}) {
    return Container(
      width: Get.width / 3.6,
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
          Icon(
            Icons.keyboard_arrow_down,
            size: Get.width / 20,
            color: Colors.grey,
          ),
        ],
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
}
