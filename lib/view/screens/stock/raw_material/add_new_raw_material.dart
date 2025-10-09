import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../routes/routes.dart';
import '../../../component/textfield.dart';

class AddNewRawMaterial extends StatefulWidget {
  const AddNewRawMaterial({super.key});

  @override
  State<AddNewRawMaterial> createState() => _AddNewRawMaterialState();
}

class _AddNewRawMaterialState extends State<AddNewRawMaterial> {
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
                            'Add New Raw Material',
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
                              Get.toNamed(Routes.viewAllRawMaterial);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xffF78520),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'View All Material',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Get.width / 34.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height / 40),
                      CustomTextField(label: "Material Code", hint: "RM016"),
                      Text(
                        "Auto-generated unique code",
                        style: TextStyle(
                          fontSize: Get.width / 41.5,
                          color: Color(0xff868686),
                        ),
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Material Name",
                        hint: "Sep 12, 2025 11:00 AM",
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField(
                        label: "Category",
                        items: [1, 2, 3],
                        value: "Select Category",
                        getLabel: (val) {
                          return val.toString();
                        },
                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField(
                        label: "Supplier",
                        items: [1, 2, 3],
                        value: "Select supplier",
                        getLabel: (val) {
                          return val.toString();
                        },
                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField(
                        label: "Unit",
                        items: [1, 2, 3],
                        value: "Select Unit",
                        getLabel: (val) {
                          return val.toString();
                        },
                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(label: "Initial Stock", hint: "0"),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(label: "Minimum Stock Level", hint: "0"),
                      Text(
                        "Alert when stock falls below this level",
                        style: TextStyle(
                          fontSize: Get.width / 41.5,
                          color: Color(0xff868686),
                        ),
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(label: "Maximum Stock Level", hint: "0"),
                      Text(
                        "Maximum stock to maintain",
                        style: TextStyle(
                          fontSize: Get.width / 41.5,
                          color: Color(0xff868686),
                        ),
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(label: "Cost per Unit", hint: "tesr"),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(label: "Address", hint: "tesr"),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(label: "GST", hint: "tesr"),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(label: "Cost per Unit", hint: "0"),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField(
                        label: "Statue",
                        items: ["Active", "InActive"],
                        value: "Active",
                        getLabel: (val) {
                          return val.toString();
                        },
                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField(
                        label: "Description",
                        items: ["Active", "InActive"],
                        value: "Active",
                        getLabel: (val) {
                          return val.toString();
                        },
                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      UploadFileField(
                        label: "Material Image",
                        onFileSelected: (val) {},
                      ),
                      Text(
                        "Upload an image of the material (optional) ",
                        style: TextStyle(
                          fontSize: Get.width / 41.5,
                          color: Color(0xff868686),
                        ),
                      ),
                      SizedBox(height: Get.height / 60),
                      SizedBox(
                        width: double.infinity,
                        height: Get.height / 18,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffF78520),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Add Raw Materials",
                            style: GoogleFonts.poppins(
                              fontSize: Get.width / 22.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
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
