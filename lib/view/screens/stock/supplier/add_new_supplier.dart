import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/main.dart';

import '../../../../model/supplier_model/supplier_model.dart';
import '../../../component/textfield.dart';

class AddNewSupplier extends StatefulWidget {
  const AddNewSupplier({super.key});

  @override
  State<AddNewSupplier> createState() => _AddNewSupplierState();
}

class _AddNewSupplierState extends State<AddNewSupplier> {
  bool isEdit = false;
  Supplier? supplier;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args != null && args['isEdit'] == true && args['supplier'] != null) {
      isEdit = true;
      supplier = args['supplier'] as Supplier;
      addSupplierController.fillSupplierData(supplier!);
    } else {
      isEdit = false;
      addSupplierController.clearAllFields();
    }
  }

  @override
  Widget build(BuildContext context) {
    final String screenTitle = isEdit ? "Edit Supplier" : "Add New Supplier";
    final String buttonText = isEdit ? "Update Supplier" : "Add Supplier";

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: Get.height / 30),

            // ---------------- App Bar ----------------
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Get.width / 25,
                vertical: Get.height / 100,
              ),
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xffF78520),
                    ),
                    onPressed: () {
                      Get.back();
                      addSupplierController.clearAllFields();
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        screenTitle,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: Get.width / 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Get.width / 15),
                ],
              ),
            ),

            // ---------------- Form Section ----------------
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
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                          color: const Color(0xff868686),
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

                      // ✅ Custom Dropdown for Status
                      Obx(() {
                        return CustomDropdownField<String>(
                          label: "Status",
                          items: const ["Active", "Inactive"],
                          value:
                              addSupplierController
                                  .selectedStatus
                                  .value
                                  .isNotEmpty
                              ? addSupplierController.selectedStatus.value
                              : null,
                          hint: "Select Status",
                          getLabel: (val) => val,
                          onChanged: (val) {
                            if (val != null) {
                              addSupplierController.selectedStatus.value = val;
                              addSupplierController.statusController.text = val;
                            }
                          },
                        );
                      }),
                      SizedBox(height: Get.height / 60),

                      // ---------- Submit Button ----------
                      Obx(
                        () => SizedBox(
                          width: double.infinity,
                          height: Get.height / 18,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF78520),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () async {
                              bool success = false;

                              if (isEdit && supplier?.supplierId != null) {
                                success = await addSupplierController
                                    .updateSupplier(supplier!.supplierId);
                              } else {
                                await addSupplierController.addSupplier();
                                success = true;
                              }

                              if (success) {
                                await supplierController.fetchSuppliers();
                                Get.back();
                              }
                            },

                            child: addSupplierController.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    buttonText,
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
