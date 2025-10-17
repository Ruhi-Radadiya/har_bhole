import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../main.dart';
import '../../../../model/supplier_model/supplier_model.dart';
import '../../../component/textfield.dart';

class ViewSupplierScreen extends StatelessWidget {
  const ViewSupplierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch suppliers when the screen loads
    supplierController.fetchSuppliers();

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
                        onPressed: () => Get.back(),
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
            // Supplier list
            Expanded(
              child: Obx(() {
                if (supplierController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xffF78520)),
                  );
                }

                if (supplierController.suppliersList.isEmpty) {
                  return const Center(child: Text("No suppliers found"));
                }

                return SingleChildScrollView(
                  padding: EdgeInsets.all(Get.width / 30),
                  child: Column(
                    children: supplierController.suppliersList.map<Widget>((
                      Supplier supplier,
                    ) {
                      return Container(
                        margin: EdgeInsets.only(bottom: Get.height / 30),
                        padding: EdgeInsets.all(Get.width / 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Buttons Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Edit Button
                                GestureDetector(
                                  onTap: () {
                                    // Navigate to edit supplier screen
                                    // Get.to(() => EditSupplierScreen(supplier: supplier));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xffF78520),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(
                                        color: const Color(0xffF78520),
                                        fontWeight: FontWeight.bold,
                                        fontSize: Get.width / 36,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: Get.width / 100),
                                // Delete Button
                                GestureDetector(
                                  onTap: () async {
                                    // Show custom styled confirmation dialog
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
                                          "Are you sure you want to delete this supplier?",
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
                                        // Call delete function
                                        await addSupplierController
                                            .deleteSupplier(
                                              supplier.supplierId,
                                            );

                                        // Refresh supplier list
                                        supplierController.fetchSuppliers();

                                        // Close dialog
                                        if (Get.isDialogOpen ?? false)
                                          Get.back();
                                      },
                                      onCancel: () {
                                        if (Get.isDialogOpen ?? false)
                                          Get.back();
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xffF78520),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                        color: const Color(0xffF78520),
                                        fontWeight: FontWeight.bold,
                                        fontSize: Get.width / 36,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Get.height / 30),
                            // Filter Fields Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildFilterField(
                                  label: "Status",
                                  child: _buildFilterDropdown(
                                    label: supplier.status,
                                  ),
                                ),
                                _buildFilterField(
                                  label: "City",
                                  child: _buildFilterDropdown(
                                    label: supplier.city,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Get.height / 40),
                            // Supplier Details Fields
                            CustomTextField(
                              label: "Code",
                              hint: supplier.supplierCode ?? "-",
                            ),
                            SizedBox(height: Get.height / 60),
                            CustomTextField(
                              label: "Name",
                              hint: supplier.supplierName,
                            ),
                            SizedBox(height: Get.height / 60),
                            CustomTextField(
                              label: "Phone Number",
                              hint: supplier.phone,
                            ),
                            SizedBox(height: Get.height / 60),
                            CustomTextField(
                              label: "Email Id",
                              hint: supplier.email,
                            ),
                            SizedBox(height: Get.height / 60),
                            CustomTextField(
                              label: "Location",
                              hint:
                                  "${supplier.address}, ${supplier.city}, ${supplier.state}",
                            ),
                            SizedBox(height: Get.height / 60),
                            CustomTextField(
                              label: "Payment Terms",
                              hint: supplier.paymentTerms,
                            ),
                            SizedBox(height: Get.height / 60),
                            CustomTextField(
                              label: "Credit Limit",
                              hint: "₹${supplier.creditLimit}",
                            ),
                            SizedBox(height: Get.height / 60),
                            CustomTextField(
                              label: "Status",
                              hint: supplier.status,
                            ),
                            SizedBox(height: Get.height / 60),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
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
          Text(
            label,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: Get.width / 36,
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
