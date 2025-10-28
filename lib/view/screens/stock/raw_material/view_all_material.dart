import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/main.dart';

import '../../../../model/raw_material_model/raw_material_model.dart';
import '../../../component/textfield.dart';

class ViewAllRawMaterial extends StatelessWidget {
  const ViewAllRawMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    final RawMaterialModel item = Get.arguments; // ✅ Get passed material

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
                  'Raw Material',
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
                        // Header Row
                        Text(
                          'Raw Material Details',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: Get.width / 22.5,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xffF78520),
                            ),
                          ),
                        ),
                        // SizedBox(height: Get.height / 50),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     _buildFilterField(
                        //       label: "Category",
                        //       child: _buildFilterDropdown(
                        //         label: "All categories",
                        //       ),
                        //     ),
                        //     _buildFilterField(
                        //       label: "Status",
                        //       child: _buildFilterDropdown(label: "All Status"),
                        //     ),
                        //     _buildFilterField(
                        //       label: "Stock Status",
                        //       child: _buildFilterDropdown(label: "All Stock"),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: Get.height / 40),
                        CustomTextField(
                          label: 'Material Code',
                          controller: TextEditingController(
                            text: item.stockId ?? '',
                          ),
                          isReadOnly: true,
                          hint: '',
                        ),
                        SizedBox(height: Get.height / 40),
                        CustomTextField(
                          label: 'Material Name',
                          controller: TextEditingController(
                            text: item.materialName ?? '',
                          ),
                          isReadOnly: true,
                          hint: '',
                        ),
                        SizedBox(height: Get.height / 40),
                        CustomTextField(
                          label: 'Description',
                          controller: TextEditingController(
                            text: item.description ?? '',
                          ),
                          isReadOnly: true,
                          hint: '',
                        ),
                        SizedBox(height: Get.height / 40),
                        CustomTextField(
                          label: 'Current Quantity',
                          controller: TextEditingController(
                            text: item.currentQuantity ?? '',
                          ),
                          isReadOnly: true,
                          hint: '',
                        ),
                        SizedBox(height: Get.height / 40),
                        CustomTextField(
                          label: 'Cost / Unit',
                          controller: TextEditingController(
                            text: item.costPerUnit?.toString() ?? '',
                          ),
                          isReadOnly: true,
                          hint: '',
                        ),
                        SizedBox(height: Get.height / 40),
                        CustomTextField(
                          label: 'Total Value',
                          controller: TextEditingController(
                            text: '₹${item.totalValue ?? ''}',
                          ),
                          isReadOnly: true,
                          hint: '',
                        ),
                        SizedBox(height: Get.height / 40),
                        CustomTextField(
                          label: 'Status',
                          controller: TextEditingController(
                            text: item.status ?? '',
                          ),
                          isReadOnly: true,
                          hint: '',
                        ),

                        SizedBox(height: Get.height / 20),
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

                                  // ✅ Call your controller delete method
                                  await rawMaterialController.deleteRawMaterial(
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
          const Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.grey),
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
