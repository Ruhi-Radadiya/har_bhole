import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../routes/routes.dart';
import '../../../component/textfield.dart';

class CreateNewSemiFinishedProductScreen extends StatelessWidget {
  const CreateNewSemiFinishedProductScreen({super.key});

  final Color mainOrange = const Color(0xffF78520);
  final Color lightGrayBackground = const Color(0xffF3F7FC);

  final String? _selectedCategory = null;
  final String? _selectedRawMaterial = null;
  final String? _selectedOutputType = null;

  @override
  Widget build(BuildContext context) {
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.viewAllSemiFinishedMaterial);
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
                      _buildSectionHeader('Create Semi-Finished Product'),
                      CustomTextField(
                        label: 'Item Code',
                        hint: 'SF023',
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: 'Item Name',
                        hint: 'Enter Product Name',
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomDropdownField<String>(
                        label: 'Category',
                        items: const ['Category A', 'Category B', 'Category C'],
                        value: _selectedCategory,
                        getLabel: (val) => val,
                        onChanged: (val) {},
                        hint: 'Select Category',
                      ),
                      SizedBox(height: Get.height / 60),

                      UploadFileField(
                        label: 'Product Image',
                        onFileSelected: (path) {},
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: 'Description',
                        hint: 'Enter Product discription or note',
                        maxLines: 2,
                      ),
                      SizedBox(height: Get.height / 60),

                      _buildSectionHeader(
                        'Bill of Materials (BOM)',
                        actionText: 'Add',
                        onActionTap: () {},
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomDropdownField<String>(
                        label: 'Raw Material',
                        items: const ['Raw Mat A', 'Raw Mat B', 'Raw Mat C'],
                        value: _selectedRawMaterial,
                        getLabel: (val) => val,
                        onChanged: (val) {},
                        hint: 'Select raw Material',
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: 'Quantity Required',
                        hint: '0.00',
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: 'Unit',
                        hint: '0',
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Wastage+',
                            style: TextStyle(
                              fontSize: Get.width / 26,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff000000),
                            ),
                          ),
                          SizedBox(height: Get.height / 150),
                          CustomTextField(
                            hint: '0.00',
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: Get.height / 60),
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.only(bottom: Get.height / 50),
                        child: Text(
                          'No raw materials added yet. add materials to define the production recipe.',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: Get.width / 40,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ),

                      _buildSectionHeader(
                        'Production Output',
                        actionText: 'Edit',
                        onActionTap: () {},
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomDropdownField<String>(
                        label: 'Output Type',
                        items: const ['Type A', 'Type B', 'Type C'],
                        value: _selectedOutputType,
                        getLabel: (val) => val,
                        onChanged: (val) {},
                        hint: 'Select Output Type',
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: 'Quantity Created',
                        hint: '0.00',
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: 'Box Weight (kg)',
                        hint: '0.00',
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: 'Box Dimensions (cm)',
                        hint: 'L x W x H',
                      ),
                      SizedBox(height: Get.height / 30),
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
                            "Add Semi-Finished Materials",
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

  Widget _buildSectionHeader(
    String title, {
    String? actionText,
    VoidCallback? onActionTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height / 50, bottom: Get.height / 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: Get.width / 20,
                fontWeight: FontWeight.bold,
                color: mainOrange,
              ),
            ),
          ),
          if (actionText != null)
            GestureDetector(
              onTap: onActionTap,
              child: Text(
                actionText,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: Get.width / 22.5,
                    fontWeight: FontWeight.w600,
                    color: mainOrange,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
