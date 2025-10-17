import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/main.dart';

import '../../../../routes/routes.dart';
import '../../../component/textfield.dart';

class AddNewSupplier extends StatelessWidget {
  const AddNewSupplier({super.key});

  @override
  Widget build(BuildContext context) {
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
                      Expanded(
                        child: Center(
                          child: Text(
                            'Add New Supplier',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: Get.width / 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: Get.width / 15),
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
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
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
                            onTap: () {
                              Get.toNamed(Routes.viewAllSupplier);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xffF78520),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'View All Supplier',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Get.width / 34.5,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: Get.width / 50),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xffF78520),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'cancel',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: Get.width / 34.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height / 40),

                      // Connect controllers here
                      CustomTextField(
                        label: "Supplier Code",
                        hint: "SUP001",
                        controller:
                            addSupplierController.supplierCodeController,
                      ),
                      Text(
                        "Unique supplier identifier",
                        style: TextStyle(
                          fontSize: Get.width / 41.5,
                          color: Color(0xff868686),
                        ),
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "Supplier Name",
                        hint: "Supplier Name",
                        controller:
                            addSupplierController.supplierNameController,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "Contact Person",
                        hint: "Contact Person",
                        controller:
                            addSupplierController.contactPersonController,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "Phone Number",
                        hint: "+91 9876543210",
                        controller: addSupplierController.phoneController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "Email Address",
                        hint: "supplier@gmail.com",
                        controller: addSupplierController.emailController,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "Website",
                        hint: "https://www.website.com",
                        controller: addSupplierController.websiteController,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "Address",
                        hint: "Complete Address",
                        maxLines: 3,
                        controller: addSupplierController.addressController,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "City",
                        hint: "City",
                        controller: addSupplierController.cityController,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "State",
                        hint: "State",
                        controller: addSupplierController.stateController,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "Pin Code",
                        hint: "123456",
                        controller: addSupplierController.pinCodeController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "Country",
                        hint: "India",
                        controller: addSupplierController.countryController,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "GST Number",
                        hint: "0",
                        controller: addSupplierController.gstNumberController,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "PAN Number",
                        hint: "AAACB1234F",
                        controller: addSupplierController.panNumberController,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "Payment Terms",
                        hint: "Net 30",
                        controller:
                            addSupplierController.paymentTermsController,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "Credit Limit (₹)",
                        hint: "0.00",
                        controller: addSupplierController.creditLimitController,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "Notes",
                        hint: "Additional note about supplier",
                        maxLines: 3,
                        controller: addSupplierController.notesController,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "Status",
                        hint: "Active",
                        controller: addSupplierController.statusController,
                      ),
                      SizedBox(height: Get.height / 60),

                      // Button with API call
                      Obx(
                        () => SizedBox(
                          width: double.infinity,
                          height: Get.height / 18,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffF78520),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: addSupplierController.isLoading.value
                                ? null
                                : () {
                                    addSupplierController.addSupplier();
                                  },
                            child: addSupplierController.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Add Movement",
                                    style: GoogleFonts.poppins(
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
              ),
            ),
            SizedBox(height: Get.height / 20),
          ],
        ),
      ),
    );
  }
}
