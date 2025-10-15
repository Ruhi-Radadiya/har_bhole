import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../main.dart';
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
                        hint: '',
                        isReadOnly: true,
                        controller: addFinishedGoodsStockController
                            .productCodeController,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Product Name',
                        hint: 'Enter Product Name',
                        controller: addFinishedGoodsStockController
                            .productNameController,
                      ),
                      SizedBox(height: Get.height / 60),
                      Obx(
                        () => CustomDropdownField<String>(
                          label: 'Category',
                          items: const [
                            'Category A',
                            'Category B',
                            'Category C',
                          ],
                          value:
                              addFinishedGoodsStockController
                                  .selectedCategory
                                  .value
                                  .isEmpty
                              ? null
                              : addFinishedGoodsStockController
                                    .selectedCategory
                                    .value,
                          getLabel: (val) => val,
                          onChanged: (val) {
                            addFinishedGoodsStockController
                                    .selectedCategory
                                    .value =
                                val ?? '';
                          },
                          hint: 'Select Category',
                        ),
                      ),

                      SizedBox(height: Get.height / 60),
                      UploadFileField(
                        label: 'Product Image',
                        onFileSelected: (path) {
                          addFinishedGoodsStockController.selectedImage.value =
                              File(path);
                        },
                      ),

                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Description',
                        hint: 'Enter Product discription or note',
                        maxLines: 2,
                        controller: addFinishedGoodsStockController
                            .descriptionController,
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
                        value:
                            addFinishedGoodsStockController
                                .selectedRawMaterial
                                .value
                                .isEmpty
                            ? null
                            : addFinishedGoodsStockController
                                  .selectedRawMaterial
                                  .value,
                        getLabel: (val) => val,
                        onChanged: (val) {
                          if (val != null) {
                            addFinishedGoodsStockController
                                    .selectedRawMaterial
                                    .value =
                                val;
                          }
                        },
                        hint: 'Select Semi-Finished Material',
                      ),

                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Quantity Required',
                        hint: '0.00',
                        keyboardType: TextInputType.number,
                        controller: addFinishedGoodsStockController
                            .quantityProducedController,
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
                      CustomTextField(
                        label: 'Unit of Measure',
                        hint: 'Enter Unit',
                        controller: addFinishedGoodsStockController
                            .unitOfMeasureController,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Quantity Produced',
                        hint: '0.00',
                        keyboardType: TextInputType.number,
                        controller: addFinishedGoodsStockController
                            .quantityProducedController,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Total Weight (grams)',
                        hint: '0.00',
                        keyboardType: TextInputType.number,
                        controller: addFinishedGoodsStockController
                            .totalWeightController,
                        isReadOnly: true,
                      ),
                      _buildSectionHeader(
                        'Variants (Weight-wise)',
                        actionText: 'Add',
                        onActionTap: () {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Weight (grams)',
                        hint: 'e.g. 250',
                        keyboardType: TextInputType.number,
                        controller: addFinishedGoodsStockController
                            .weightGramsController,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Quantity (units)',
                        hint: '0',
                        keyboardType: TextInputType.number,
                        controller: addFinishedGoodsStockController
                            .quantityProducedController,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Total Weight (grams)',
                        hint: '0.00',
                        keyboardType: TextInputType.number,
                        controller: addFinishedGoodsStockController
                            .totalWeightController,
                        isReadOnly: true,
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
                        controller: addFinishedGoodsStockController
                            .descriptionController,
                      ),
                      SizedBox(height: Get.height / 30),
                      SizedBox(
                        width: double.infinity,
                        height: Get.height / 18,
                        child: Obx(
                          () => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffF78520),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed:
                                addFinishedGoodsStockController.isLoading.value
                                ? null
                                : () {
                                    addFinishedGoodsStockController
                                        .addFinishedGood();
                                  },
                            child:
                                addFinishedGoodsStockController.isLoading.value
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    "Create Finished Goods",
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
