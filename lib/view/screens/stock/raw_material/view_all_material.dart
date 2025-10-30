import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/main.dart';

import '../../../../model/raw_material_model/raw_material_model.dart';
import '../../../component/textfield.dart';
import 'add_new_raw_material.dart';

class ViewAllRawMaterial extends StatelessWidget {
  const ViewAllRawMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    final RawMaterialModel item = Get.arguments as RawMaterialModel;

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
                        SizedBox(height: Get.height / 40),
                        CustomTextField(
                          label: 'Material Code',
                          controller: TextEditingController(
                            text: item.materialCode ?? '',
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
                            text: item.stock?.toString() ?? '',
                          ),
                          isReadOnly: true,
                          hint: '',
                        ),
                        SizedBox(height: Get.height / 40),
                        CustomTextField(
                          label: 'Cost / Unit',
                          controller: TextEditingController(
                            text: item.costPrice ?? '',
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

                        /// ✅ EDIT BUTTON
                        SizedBox(
                          height: Get.height / 18,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Fill controller with data (safe conversion done in controller)
                              rawMaterialController.fillMaterialData(item);

                              // Navigate to Add/Edit screen and pass args
                              Get.to(
                                () => const AddNewRawMaterial(),
                                arguments: {"isEdit": true, "material": item},
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

                        /// ❌ DELETE BUTTON
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
                                  await rawMaterialController.deleteRawMaterial(
                                    item.stockId ?? '',
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
}
