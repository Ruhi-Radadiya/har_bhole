import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../routes/routes.dart';
import '../../../component/textfield.dart';

class AddNewSupplier extends StatelessWidget {
  const AddNewSupplier({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                      CustomTextField(label: "Supplier Code", hint: "SUP001"),
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
                        hint: "Sep 12, 2025 11:00 AM",
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField(
                        label: "Contact Person",
                        items: [1, 2, 3],
                        value: "Primary Contact NUmber",
                        getLabel: (val) {
                          return val.toString();
                        },
                        onChanged: (val) {},
                        hint: "Primary Contact NUmber",
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField(
                        label: "Phone Number",
                        items: [1, 2, 3],
                        value: "+91 95663 54236",
                        getLabel: (val) {
                          return val.toString();
                        },
                        onChanged: (val) {},
                        hint: "+91 95663 54236",
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField(
                        label: "Email Address",
                        items: [1, 2, 3],
                        value: "Supplier@gmail.com",
                        getLabel: (val) {
                          return val.toString();
                        },
                        onChanged: (val) {},
                        hint: "Supplier@gmail.com",
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(label: "Website", hint: "0"),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "Address",
                        hint: "Complete Address",
                        maxLines: 3,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(label: "City", hint: "0"),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(label: "state", hint: "tesr"),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(label: "Pin Code", hint: "123456"),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(label: "Country", hint: "India"),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(label: "GST Number", hint: "0"),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField(
                        label: "PAN Number",
                        items: ["Active", "InActive"],
                        value: "Active",
                        getLabel: (val) {
                          return val.toString();
                        },
                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField(
                        label: "Payment Terms",
                        items: ["Active", "InActive"],
                        value: "Active",
                        getLabel: (val) {
                          return val.toString();
                        },
                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(label: "Credit Limit (₹)", hint: "0.00"),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Notes",
                        hint: "Addtional note about supplier",
                        maxLines: 3,
                      ),
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
                            "Add Movement",
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
