import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/main.dart';

import '../../../../model/semi_finished_material_model/semi_finished_material_model.dart';
import '../../../component/textfield.dart';

class CreateNewSemiFinishedProductScreen extends StatefulWidget {
  const CreateNewSemiFinishedProductScreen({super.key});

  @override
  State<CreateNewSemiFinishedProductScreen> createState() =>
      _CreateNewSemiFinishedProductScreenState();
}

class _CreateNewSemiFinishedProductScreenState
    extends State<CreateNewSemiFinishedProductScreen> {
  final Color mainOrange = const Color(0xffF78520);
  final Color lightGrayBackground = const Color(0xffF3F7FC);

  String? _selectedCategory;
  String? _selectedRawMaterial;
  String? _selectedOutputType;

  final itemCodeController = TextEditingController();
  final itemNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final quantityRequiredController = TextEditingController();
  final unitController = TextEditingController();
  final wastageController = TextEditingController();
  final quantityCreatedController = TextEditingController();
  final boxWeightController = TextEditingController();
  final boxDimensionsController = TextEditingController();

  bool isLoading = false;
  bool isEditMode = false;
  Map<String, dynamic>? editProductData;
  String? productId;

  // For BOM items
  List<BomItem> bomItems = [];

  @override
  void initState() {
    super.initState();

    // Check if we're in edit mode
    final arguments = Get.arguments;
    if (arguments != null && arguments['isEdit'] == true) {
      isEditMode = true;
      editProductData = arguments['productData'];
      productId = editProductData?['stock_id']?.toString();
      _prefillFormData();
    } else {
      semiFinishedController.generateItemCode();
    }
  }

  void _prefillFormData() {
    if (editProductData == null) return;

    setState(() {
      itemCodeController.text = editProductData?['item_code']?.toString() ?? '';
      itemNameController.text = editProductData?['item_name']?.toString() ?? '';
      descriptionController.text =
          editProductData?['description']?.toString() ?? '';
      _selectedCategory = editProductData?['category_id']?.toString();
      _selectedOutputType = editProductData?['output_type']?.toString();
      quantityCreatedController.text =
          editProductData?['current_quantity']?.toString() ?? '';
      unitController.text =
          editProductData?['unit_of_measure']?.toString() ?? 'kg';
      boxWeightController.text =
          editProductData?['box_weight']?.toString() ?? '';
      boxDimensionsController.text =
          editProductData?['box_dimensions']?.toString() ?? '';
      if (editProductData?['bom_items'] != null &&
          editProductData?['bom_items'] is List) {
        final List<dynamic> bomData = editProductData?['bom_items'];
        if (bomData.isNotEmpty) {
          final firstBom = bomData.first;
          quantityRequiredController.text =
              firstBom['quantity_required']?.toString() ?? '';
          wastageController.text =
              firstBom['wastage_percentage']?.toString() ?? '';
          _selectedRawMaterial = firstBom['raw_material_id']?.toString();
        }
      }
    });
  }

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
                      Expanded(
                        child: Text(
                          isEditMode ? 'Edit Product' : 'Create New Product',
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
                        isEditMode
                            ? 'Edit Semi-Finished Product'
                            : 'Create Semi-Finished Product',
                      ),
                      CustomTextField(
                        label: 'Item Code',
                        hint: 'SF023',
                        controller: itemCodeController,
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Item Name',
                        hint: 'Enter Product Name',
                        controller: itemNameController,
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
                      UploadFileField(
                        label: 'Product Image',
                        onFileSelected: (path) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Description',
                        hint: 'Enter Product description or note',
                        controller: descriptionController,
                        maxLines: 2,
                      ),
                      SizedBox(height: Get.height / 60),

                      _buildSectionHeader(
                        'Bill of Materials (BOM)',
                        actionText: 'Add',
                        onActionTap: () {},
                      ),
                      SizedBox(height: Get.height / 60),

                      Obx(() {
                        if (rawMaterialController.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (rawMaterialController.errorMessage.isNotEmpty) {
                          return Text(
                            rawMaterialController.errorMessage.value,
                            style: const TextStyle(color: Colors.red),
                          );
                        }

                        if (rawMaterialController.filteredMaterials.isEmpty) {
                          return const Text('No raw materials available');
                        }

                        final materialNames = rawMaterialController
                            .filteredMaterials
                            .map((e) => e.materialName ?? '')
                            .toSet()
                            .toList();

                        if (_selectedRawMaterial != null &&
                            !materialNames.contains(_selectedRawMaterial)) {
                          _selectedRawMaterial = null;
                        }

                        return CustomDropdownField<String>(
                          label: 'Raw Material',
                          items: materialNames,
                          value: _selectedRawMaterial,
                          getLabel: (val) => val,
                          onChanged: (val) {
                            setState(() {
                              _selectedRawMaterial = val;
                            });
                          },
                          hint: 'Select Raw Material',
                        );
                      }),

                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: 'Quantity Required',
                        hint: '0.00',
                        controller: quantityRequiredController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: 'Unit',
                        hint: 'kg',
                        controller: unitController,
                      ),
                      SizedBox(height: Get.height / 60),

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
                        controller: wastageController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),

                      Padding(
                        padding: EdgeInsets.only(bottom: Get.height / 50),
                        child: Text(
                          isEditMode && bomItems.isNotEmpty
                              ? '${bomItems.length} BOM item(s) configured'
                              : 'No raw materials added yet. Add materials to define the production recipe.',
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
                        onChanged: (val) {
                          setState(() => _selectedOutputType = val);
                        },
                        hint: 'Select Output Type',
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: 'Quantity Created',
                        hint: '0.00',
                        controller: quantityCreatedController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: 'Box Weight (kg)',
                        hint: '0.00',
                        controller: boxWeightController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: 'Box Dimensions (cm)',
                        hint: 'L x W x H',
                        controller: boxDimensionsController,
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
                          onPressed: isLoading
                              ? null
                              : isEditMode
                              ? semiFinishedController.editSemiFinishedMaterial
                              : semiFinishedController.addSemiFinishedMaterial,
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  isEditMode
                                      ? "Update Product"
                                      : "Add Semi-Finished Materials",
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
