import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../main.dart';
import '../../../../model/supplier_model/supplier_model.dart';
import '../../../component/textfield.dart';
import 'add_new_supplier.dart';

class ViewSupplierScreen extends StatelessWidget {
  const ViewSupplierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the selected supplier passed from the previous screen
    final Supplier supplier = Get.arguments;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: Get.height / 30),

            // Header
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
                        onPressed: () {
                          supplierController.isActive.value = true;
                          Get.back();
                        },
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(minWidth: Get.width / 15),
                      ),
                      SizedBox(width: Get.width / 100),
                      Text(
                        'Supplier Details',
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
                ],
              ),
            ),

            // Details section
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(Get.width / 20),
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
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     _buildFilterField(
                      //       label: "Status",
                      //       child: _buildFilterDropdown(
                      //         label: supplier.status ?? "-",
                      //       ),
                      //     ),
                      //     _buildFilterField(
                      //       label: "City",
                      //       child: _buildFilterDropdown(
                      //         label: supplier.city ?? "-",
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: Get.height / 30),
                      CustomTextField(
                        label: "Supplier Code",
                        hint: supplier.supplierCode ?? "-",
                      ),
                      SizedBox(height: Get.height / 50),
                      CustomTextField(
                        label: "Supplier Name",
                        hint: supplier.supplierName ?? "-",
                      ),
                      SizedBox(height: Get.height / 50),
                      CustomTextField(
                        label: "Phone Number",
                        hint: supplier.phone ?? "-",
                      ),
                      SizedBox(height: Get.height / 50),
                      CustomTextField(
                        label: "Email ID",
                        hint: supplier.email ?? "-",
                      ),
                      SizedBox(height: Get.height / 50),
                      CustomTextField(
                        label: "Location",
                        hint:
                            "${supplier.address ?? '-'}, ${supplier.city ?? '-'}, ${supplier.state ?? '-'}",
                      ),
                      SizedBox(height: Get.height / 50),
                      CustomTextField(
                        label: "Payment Terms",
                        hint: supplier.paymentTerms ?? "-",
                      ),
                      SizedBox(height: Get.height / 50),
                      CustomTextField(
                        label: "Credit Limit",
                        hint: supplier.creditLimit != null
                            ? "₹${supplier.creditLimit}"
                            : "-",
                      ),
                      SizedBox(height: Get.height / 50),
                      SizedBox(
                        height: Get.height / 18,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            addSupplierController.fillSupplierData(
                              supplier,
                            ); // ✅ fill data first
                            Get.to(
                              () => const AddNewSupplier(),
                              arguments: {"isEdit": true, "supplier": supplier},
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
                      SizedBox(
                        height: Get.height / 18,
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () async {
                            await Get.defaultDialog(
                              title: "Delete Supplier",
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
                                  "Are you sure you want to delete ${supplier.supplierName}?",
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
                                await supplierController.deleteSupplier(
                                  supplier.supplierId.toString(),
                                );

                                // Give a short delay before navigating back to list
                                Future.delayed(
                                  const Duration(milliseconds: 300),
                                  () {
                                    Get.back(); // return to supplier list
                                  },
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
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }

  Widget _buildFilterDropdown({required String label}) {
    return Container(
      width: Get.width / 3,
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
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: Get.width / 36,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.grey),
        ],
      ),
    );
  }
}
