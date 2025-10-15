import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../main.dart';
import '../../../../model/supplier_model/supplier_model.dart';
import '../../../component/textfield.dart';

class ViewSupplierScreen extends StatelessWidget {
  ViewSupplierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch suppliers when screen opens
    supplierController.fetchSuppliers();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  child: Container(
                                    padding: const EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xffF78520),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(
                                        color: Color(0xffF78520),
                                        fontWeight: FontWeight.bold,
                                        fontSize: Get.width / 36,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: Get.width / 100),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xffF78520),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Color(0xffF78520),
                                      fontWeight: FontWeight.bold,
                                      fontSize: Get.width / 36,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Get.height / 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildFilterField(
                                  label: "Statue",
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
                              label: "Statue",
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
          SizedBox(height: 6),
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
