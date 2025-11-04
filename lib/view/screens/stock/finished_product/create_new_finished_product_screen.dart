import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../main.dart';
import '../../../component/textfield.dart';

class CreateNewFinishedProductScreen extends StatefulWidget {
  const CreateNewFinishedProductScreen({super.key});

  @override
  State<CreateNewFinishedProductScreen> createState() =>
      _CreateNewFinishedProductScreenState();
}

class _CreateNewFinishedProductScreenState
    extends State<CreateNewFinishedProductScreen> {
  final Color mainOrange = const Color(0xffF78520);

  @override
  Widget build(BuildContext context) {
    // 🔹 Check if screen is opened in edit mode
    final args = Get.arguments ?? {};
    final bool isEdit = args['isEdit'] ?? false;
    final productData = args['productData'];
    String? _selectedCategory;

    if (isEdit && productData != null) {
      addFinishedGoodsStockController.fillFormForEdit(productData);
    }

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
                        child: Text(
                          isEdit ? 'Edit Goods' : 'Create Finished Goods',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: Get.width / 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: Get.width / 15),
                    ],
                  ),
                ],
              ),
            ),
            // 🔹 Form Section
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
                      _buildSectionHeader(
                        isEdit ? 'Edit Finished Good' : 'Add New Finished Good',
                      ),

                      // Product Code
                      CustomTextField(
                        label: 'Product Code',
                        hint: '',
                        isReadOnly: true,
                        controller: addFinishedGoodsStockController
                            .productCodeController,
                      ),
                      SizedBox(height: Get.height / 60),

                      // Product Name
                      CustomTextField(
                        label: 'Product Name',
                        hint: 'Enter Product Name',
                        controller: addFinishedGoodsStockController
                            .productNameController,
                      ),
                      SizedBox(height: Get.height / 60),
                      Obx(() {
                        if (premiumCollectionController.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (premiumCollectionController
                            .errorMessage
                            .isNotEmpty) {
                          return Text(
                            premiumCollectionController.errorMessage.value,
                            style: const TextStyle(color: Colors.red),
                          );
                        }

                        if (premiumCollectionController
                            .filteredCategories
                            .isEmpty) {
                          return const Text('No categories available');
                        }

                        final uniqueCategories = premiumCollectionController
                            .filteredCategories
                            .map((e) => e.categoryName)
                            .toSet()
                            .toList();

                        return CustomDropdownField<String>(
                          label: 'Category',
                          items: uniqueCategories,
                          value:
                              premiumCollectionController
                                  .selectedCategory
                                  .value
                                  .isEmpty
                              ? null
                              : premiumCollectionController
                                    .selectedCategory
                                    .value,
                          getLabel: (val) => val,
                          onChanged: (val) {
                            premiumCollectionController.selectedCategory.value =
                                val ?? '';
                            print("✅ Selected category: ${val}");
                          },
                          hint: 'Select Category',
                        );
                      }),
                      SizedBox(height: Get.height / 60),

                      // Product Image
                      UploadFileField(
                        label: 'Product Image',
                        onFileSelected: (path) {
                          addFinishedGoodsStockController.selectedImage.value =
                              File(path);
                        },
                      ),
                      SizedBox(height: Get.height / 60),

                      // Description
                      CustomTextField(
                        label: 'Description',
                        hint: 'Enter Product Description or note',
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

                      // Semi-finished product dropdown
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
                          addFinishedGoodsStockController
                                  .selectedRawMaterial
                                  .value =
                              val ?? '';
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

                      // Stock management section
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
                      SizedBox(height: Get.height / 60),

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

                      // 🔹 Submit Button (Add/Edit)
                      SizedBox(
                        width: double.infinity,
                        height: Get.height / 18,
                        child: Obx(
                          () => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF78520),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed:
                                addFinishedGoodsStockController.isLoading.value
                                ? null
                                : () {
                                    if (isEdit) {
                                      addFinishedGoodsStockController
                                          .editFinishedGood();
                                    } else {
                                      addFinishedGoodsStockController
                                          .addFinishedGood();
                                    }
                                  },
                            child:
                                addFinishedGoodsStockController.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    isEdit
                                        ? "Update Finished Goods"
                                        : "Create Finished Goods",
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
