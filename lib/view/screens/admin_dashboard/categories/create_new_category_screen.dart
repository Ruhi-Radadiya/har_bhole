import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/view/component/textfield.dart';

class CreateNewCategoryScreen extends StatelessWidget {
  CreateNewCategoryScreen({super.key});

  final TextEditingController _categoryCodeController = TextEditingController(
    text: 'CAT0007',
  );
  final TextEditingController _categoryNameController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const Color mainOrange = Color(0xffF78520);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
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
                            'Create New Category',
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
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomDropdownField<String>(
                        label: "Category Type",
                        hint: "Select Category Type",
                        items: ["Main", "Sub"],
                        value: null,
                        getLabel: (item) => item,
                        onChanged: (value) {
                          // handle dropdown change
                        },
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        hint: "Enter Category Name",
                        label: "Category Name",
                        controller: _categoryNameController,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        hint: "CAT0007",
                        label: "Category Code",
                        controller: _categoryCodeController,
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        hint: "Enter Category Description",
                        label: "Description",
                        controller: _descriptionController,
                        maxLines: 3,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField<String>(
                        label: "Status",
                        hint: "Active",
                        items: ["Active", "Inactive"],
                        value: "Active",
                        getLabel: (item) => item,
                        onChanged: (value) {
                          // handle status
                        },
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(hint: "0", label: "Sort Order"),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        hint: "Yes/No",
                        label: "Show on Homepage",
                      ),
                      SizedBox(height: Get.height / 60),

                      UploadFileField(
                        label: "Category Image",
                        onFileSelected: (file) {
                          // handle file
                        },
                      ),

                      SizedBox(height: Get.height / 50),

                      // --- Create Category Button ---
                      SizedBox(
                        height: Get.height / 18,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Create Category Logic
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Create Category',
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
                      SizedBox(height: Get.height / 80),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
