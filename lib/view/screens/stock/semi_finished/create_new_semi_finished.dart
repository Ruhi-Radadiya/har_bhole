import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/main.dart';
import 'package:http/http.dart' as http;

import '../../../../routes/routes.dart';
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

  @override
  void initState() {
    super.initState();
    _generateItemCode();
  }

  Future<void> _generateItemCode() async {
    try {
      final url = Uri.parse(
        'https://harbhole.eihlims.com/Api/semi_finished_stock_api.php?action=list',
      );
      final response = await http.get(url);

      log("📦 Fetching last item codes...");
      log("📤 API Status: ${response.statusCode}");
      log("📤 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Some APIs return data["data"], others use data["items"]
        final List<dynamic> items =
            (data["data"] ?? data["items"] ?? []) as List;

        if (items.isEmpty) {
          itemCodeController.text = "SF001";
          log("⚠️ No items found, starting from SF001");
          return;
        }

        // Extract all valid codes starting with SF
        final List<String> sfCodes = items
            .map((e) => e["item_code"]?.toString() ?? "")
            .where((code) => code.startsWith("SF"))
            .toList();

        if (sfCodes.isEmpty) {
          itemCodeController.text = "SF001";
          log("⚠️ No SF codes found, starting from SF001");
          return;
        }

        // Extract numeric parts and find the largest
        final List<int> numbers = sfCodes.map((code) {
          final numericPart = code.replaceAll(RegExp(r'[^0-9]'), '');
          return int.tryParse(numericPart) ?? 0;
        }).toList();

        numbers.sort();
        final int nextNumber = (numbers.isNotEmpty ? numbers.last + 1 : 1);

        final String newCode = "SF${nextNumber.toString().padLeft(3, '0')}";

        setState(() {
          itemCodeController.text = newCode;
        });

        log("✅ Generated new code: $newCode");
      } else {
        itemCodeController.text = "SF001";
        log("⚠️ API call failed, using fallback SF001");
      }
    } catch (e) {
      itemCodeController.text = "SF001";
      log("❌ Error generating item code: $e");
    }
  }

  Future<void> _addSemiFinishedProduct() async {
    if (itemNameController.text.isEmpty ||
        _selectedCategory == null ||
        _selectedOutputType == null) {
      Get.snackbar(
        "Error",
        "Please fill all required fields",
        backgroundColor: Colors.red.shade100,
      );
      return;
    }

    setState(() => isLoading = true);

    final Map<String, dynamic> payload = {
      "item_name": itemNameController.text.trim(),
      "category_id": 3,
      "current_quantity": quantityCreatedController.text.isEmpty
          ? 0
          : double.parse(quantityCreatedController.text),
      "unit_of_measure": unitController.text.isEmpty
          ? "kg"
          : unitController.text.trim(),
      "reorder_point": 50,
      "location": "Warehouse B",
      "description": descriptionController.text.trim(),
      "output_type": _selectedOutputType ?? "",
      "box_weight": boxWeightController.text.trim(),
      "box_dimensions": boxDimensionsController.text.trim(),
      "created_by": 1,
    };

    try {
      final response = await http.post(
        Uri.parse(
          "https://harbhole.eihlims.com/Api/semi_finished_stock_api.php?action=add",
        ),
        headers: {"Content-Type": "application/json"},
        body: json.encode(payload),
      );

      final data = json.decode(response.body);
      log("🧾 Response: $data");

      if (data["success"] == true) {
        Get.snackbar(
          "Success",
          "Semi-Finished Product Added Successfully",
          backgroundColor: Colors.green.shade100,
        );
        Get.toNamed(Routes.viewAllSemiFinishedMaterial);
      } else {
        Get.snackbar(
          "Failed",
          data["message"] ?? "Something went wrong",
          backgroundColor: Colors.red.shade100,
        );
      }
    } catch (e) {
      log("❌ Error adding semi-finished material: $e");
      Get.snackbar(
        "Error",
        "Unable to connect to the server",
        backgroundColor: Colors.red.shade100,
      );
    } finally {
      setState(() => isLoading = false);
    }
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

                        // Remove duplicate category names to prevent "exactly one item" error
                        final uniqueCategories = premiumCollectionController
                            .filteredCategories
                            .map((e) => e.categoryName)
                            .toSet()
                            .toList();

                        // Ensure selected category is valid
                        if (_selectedCategory != null &&
                            !uniqueCategories.contains(_selectedCategory)) {
                          _selectedCategory = null;
                        }

                        return CustomDropdownField<String>(
                          label: 'Category',
                          items: uniqueCategories,
                          value: _selectedCategory,
                          getLabel: (val) => val,
                          onChanged: (val) {
                            setState(() => _selectedCategory = val);
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

                        // Extract material names (unique)
                        final materialNames = rawMaterialController
                            .filteredMaterials
                            .map((e) => e.materialName ?? '')
                            .toSet()
                            .toList();

                        // Fix if current selection no longer exists
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
                          onPressed: isLoading ? null : _addSemiFinishedProduct,
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
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
