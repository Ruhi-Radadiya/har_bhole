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
    final args = Get.arguments ?? {};
    final bool isEdit = args['isEdit'] ?? false;
    final productData = args['productData'];

    if (isEdit && productData != null) {
      finishedGoodsStockController.fillFormForEdit(productData);
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
                        controller:
                            finishedGoodsStockController.productCodeController,
                      ),
                      SizedBox(height: Get.height / 60),

                      // Product Name
                      CustomTextField(
                        label: 'Product Name',
                        hint: 'Enter Product Name',
                        controller:
                            finishedGoodsStockController.productNameController,
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
                        final categories = premiumCollectionController
                            .premiumCollection
                            .map((e) => e.categoryName)
                            .where((name) => name.isNotEmpty)
                            .toSet()
                            .toList();
                        if (categories.isEmpty) {
                          return const Text("No categories available");
                        }
                        return CustomDropdownField<String>(
                          label: "Category",
                          value:
                              finishedGoodsStockController
                                  .selectedCategoryName
                                  .value
                                  .isEmpty
                              ? null
                              : finishedGoodsStockController
                                    .selectedCategoryName
                                    .value,
                          items: categories,
                          onChanged: (val) {
                            if (val != null) {
                              finishedGoodsStockController
                                      .selectedCategoryName
                                      .value =
                                  val;
                              final selected = premiumCollectionController
                                  .premiumCollection
                                  .firstWhereOrNull(
                                    (e) => e.categoryName == val,
                                  );
                              if (selected != null) {
                                finishedGoodsStockController
                                        .selectedCategoryId
                                        .value =
                                    selected.categoryId;
                              }
                            }
                          },
                          getLabel: (item) => item,
                        );
                      }),
                      SizedBox(height: Get.height / 60),

                      // Product Image
                      UploadFileField(
                        label: 'Product Image',
                        onFileSelected: (path) {
                          finishedGoodsStockController.selectedImage.value =
                              File(path);
                        },
                      ),
                      SizedBox(height: Get.height / 60),

                      // Description
                      CustomTextField(
                        label: 'Description',
                        hint: 'Enter Product Description or note',
                        maxLines: 2,
                        controller:
                            finishedGoodsStockController.descriptionController,
                      ),
                      SizedBox(height: Get.height / 60),

                      _buildSectionHeader(
                        'Bill of Materials (BOM)',
                        actionText: 'Add',
                        onActionTap: () {
                          if (finishedGoodsStockController
                                  .selectedRawMaterial
                                  .value
                                  .isNotEmpty &&
                              finishedGoodsStockController
                                  .quantityProducedController
                                  .text
                                  .isNotEmpty) {
                            finishedGoodsStockController.addBomItem(
                              semiFinishedProduct: finishedGoodsStockController
                                  .selectedRawMaterial
                                  .value,
                              quantityRequired: finishedGoodsStockController
                                  .quantityProducedController
                                  .text,
                            );

                            // ✅ Clear fields after adding
                            finishedGoodsStockController
                                    .selectedRawMaterial
                                    .value =
                                '';
                            finishedGoodsStockController
                                .quantityProducedController
                                .clear();
                            finishedGoodsStockController.unitController
                                .clear(); // ✅ Clears unit field too
                          } else {
                            Get.snackbar(
                              'Missing Info',
                              'Please select a product and enter quantity.',
                            );
                          }
                        },
                      ),
                      SizedBox(height: Get.height / 60),

                      Obx(() {
                        if (semiFinishedController.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (semiFinishedController.errorMessage.isNotEmpty) {
                          return Text(
                            semiFinishedController.errorMessage.value,
                            style: const TextStyle(color: Colors.red),
                          );
                        }

                        final materials = semiFinishedController.materials
                            .map((e) => e.itemName ?? '')
                            .where((name) => name.isNotEmpty)
                            .toSet()
                            .toList();

                        if (materials.isEmpty) {
                          return const Text(
                            "No semi-finished products available",
                          );
                        }

                        return CustomDropdownField<String>(
                          label: "Semi-Finished Product",
                          value:
                              finishedGoodsStockController
                                  .selectedRawMaterial
                                  .value
                                  .isEmpty
                              ? null
                              : finishedGoodsStockController
                                    .selectedRawMaterial
                                    .value,
                          items: materials,
                          onChanged: (val) {
                            if (val != null) {
                              finishedGoodsStockController
                                      .selectedRawMaterial
                                      .value =
                                  val;

                              // ✅ Find the selected product from the semiFinished list
                              final selected = semiFinishedController.materials
                                  .firstWhereOrNull((e) => e.itemName == val);

                              if (selected != null) {
                                // ✅ Store ID if needed
                                finishedGoodsStockController
                                        .selectedRawMaterialId
                                        .value =
                                    selected.stockId ?? '';

                                // ✅ Auto-fill the unit text field directly from semi-finished API
                                finishedGoodsStockController
                                        .unitController
                                        .text =
                                    selected.unitOfMeasure ?? '';
                              }
                            }
                          },
                          getLabel: (item) => item,
                          hint: "Select Semi-Finished Product",
                        );
                      }),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Quantity Required',
                        hint: '0.00',
                        keyboardType: TextInputType.number,
                        controller: finishedGoodsStockController
                            .quantityProducedController,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Unit',
                        controller: finishedGoodsStockController.unitController,
                        isReadOnly: true, // so user can’t change it manually
                        hint: 'Select product to auto-fill unit',
                      ),
                      SizedBox(height: Get.height / 60),
                      Obx(() {
                        if (finishedGoodsStockController.bomList.isEmpty) {
                          return Text(
                            'No semi-finished products added yet. Add products to define the production recipe.',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: Get.width / 40,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          );
                        }
                        return Column(
                          children: finishedGoodsStockController.bomList
                              .asMap()
                              .entries
                              .toList() // ✅ Convert first
                              .reversed // ✅ Reverse order so newest goes bottom visually
                              .map((entry) {
                                final index = entry.key;
                                final item = entry.value;
                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  child: ListTile(
                                    title: Text(item['semiFinishedProduct']),
                                    subtitle: Text(
                                      'Qty: ${item['quantityRequired']} ${item['unit']}',
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () =>
                                          finishedGoodsStockController
                                              .removeBomItem(index),
                                    ),
                                  ),
                                );
                              })
                              .toList(),
                        );
                      }),
                      SizedBox(height: Get.height / 60),
                      _buildSectionHeader(
                        'Stock Management',
                        actionText: 'Edit',
                        onActionTap: () {},
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: 'Unit of Measure',
                        hint: 'Enter Unit',
                        controller: finishedGoodsStockController
                            .unitOfMeasureController,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: 'Quantity Produced',
                        hint: '0.00',
                        keyboardType: TextInputType.number,
                        controller: finishedGoodsStockController
                            .quantityProducedController,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: 'Total Weight (grams)',
                        hint: '0.00',
                        keyboardType: TextInputType.number,
                        controller:
                            finishedGoodsStockController.totalWeightController,
                      ),
                      SizedBox(height: Get.height / 60),

                      _buildSectionHeader(
                        'Variants (Weight-wise)',
                        actionText: 'Add',
                        onActionTap: () {
                          if (finishedGoodsStockController
                                  .weightGramsController
                                  .text
                                  .isNotEmpty &&
                              finishedGoodsStockController
                                  .quantityProducedController
                                  .text
                                  .isNotEmpty) {
                            finishedGoodsStockController.addVariant(
                              weight: finishedGoodsStockController
                                  .weightGramsController
                                  .text,
                              quantity: finishedGoodsStockController
                                  .quantityProducedController
                                  .text,
                            );

                            // ✅ Clear text fields after add
                            finishedGoodsStockController.weightGramsController
                                .clear();
                            finishedGoodsStockController
                                .quantityProducedController
                                .clear();
                          } else {
                            Get.snackbar(
                              'Missing Info',
                              'Please enter both weight and quantity.',
                            );
                          }
                        },
                      ),

                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: 'Weight (grams)',
                        hint: 'e.g. 250',
                        keyboardType: TextInputType.number,
                        controller:
                            finishedGoodsStockController.weightGramsController,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: 'Quantity (units)',
                        hint: '0',
                        keyboardType: TextInputType.number,
                        controller: finishedGoodsStockController
                            .quantityProducedController,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: 'Total Weight (grams)',
                        hint: '0.00',
                        keyboardType: TextInputType.number,
                        controller:
                            finishedGoodsStockController.totalWeightController,
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 60),
                      Obx(() {
                        if (finishedGoodsStockController.variantsList.isEmpty) {
                          return Text(
                            'No variants added yet.',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: Get.width / 40,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          );
                        }
                        return Column(
                          children: finishedGoodsStockController.variantsList
                              .asMap()
                              .entries
                              .toList()
                              .reversed // ✅ new entries go to bottom
                              .map((entry) {
                                final index = entry.key;
                                final item = entry.value;
                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  child: ListTile(
                                    title: Text('Weight: ${item['weight']} g'),
                                    subtitle: Text(
                                      'Quantity: ${item['quantity']}',
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () =>
                                          finishedGoodsStockController
                                              .removeVariant(index),
                                    ),
                                  ),
                                );
                              })
                              .toList(),
                        );
                      }),
                      SizedBox(height: Get.height / 60),

                      _buildSectionHeader('Ingredients'),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: 'Ingredients List',
                        hint: 'List all Ingredients....',
                        maxLines: 2,
                        controller:
                            finishedGoodsStockController.descriptionController,
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
                                finishedGoodsStockController.isLoading.value
                                ? null
                                : () {
                                    if (isEdit) {
                                      finishedGoodsStockController
                                          .editFinishedGood();
                                    } else {
                                      finishedGoodsStockController
                                          .addFinishedGood();
                                    }
                                  },
                            child: finishedGoodsStockController.isLoading.value
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
