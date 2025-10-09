import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../routes/routes.dart';
import '../../../component/textfield.dart';

class CreateNewFinishedProductScreen extends StatelessWidget {
  const CreateNewFinishedProductScreen({super.key});
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
                              Get.toNamed(Routes.viewNewFinishedProductScreen);
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
                      _buildSectionHeader('Add New Finished Good'),
                      CustomTextField(
                        label: 'Product Code',
                        hint: 'FG011',
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Product Name',
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
                        label: 'Semi-Finished Product',
                        items: const [
                          'Semi-Finished Mat A',
                          'Semi-Finished Mat B',
                          'Semi-Finished Mat C',
                        ],
                        value: _selectedRawMaterial,
                        getLabel: (val) => val,
                        onChanged: (val) {},
                        hint: 'Select Semi-Finished Material',
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
                      Text(
                        'No semi-finished products added yet. Add products to define the production recipe.',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: Get.width / 40,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      _buildSectionHeader(
                        'Stock Management',
                        actionText: 'Edit',
                        onActionTap: () {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField<String>(
                        label: 'Unit of Measure',
                        items: const ['Type A', 'Type B', 'Type C'],
                        value: _selectedOutputType,
                        getLabel: (val) => val,
                        onChanged: (val) {},
                        hint: 'Select Unit',
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Quantity Produced',
                        hint: '0.00',
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Total Weight (grams)',
                        hint: '0.00',
                        keyboardType: TextInputType.number,
                      ),
                      _buildSectionHeader(
                        'Variants (Weight-wise)',
                        actionText: 'Add',
                        onActionTap: () {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField<String>(
                        label: 'Weight (grams)',
                        items: const ['Type A', 'Type B', 'Type C'],
                        value: _selectedOutputType,
                        getLabel: (val) => val,
                        onChanged: (val) {},
                        hint: 'e.g. 250 ',
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Quantity (units)',
                        hint: '0',
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Total Weight (grams)',
                        hint: '0.00',
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      _buildSectionHeader(
                        'Ingredients',
                        actionText: 'Add',
                        onActionTap: () {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Ingredients List',
                        hint: 'List all Ingredients....',
                        maxLines: 2,
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
                            "Create Finished Goods",
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
