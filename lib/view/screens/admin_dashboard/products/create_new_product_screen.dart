import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../main.dart';
import '../../../../model/product_model/product_model.dart';
import '../../../component/textfield.dart';

class CreateProductScreen extends StatefulWidget {
  final Product? product;
  const CreateProductScreen({super.key, this.product});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final Product? productArg = widget.product ?? Get.arguments as Product?;
    if (productArg != null) {
      _fillFields(productArg);
    } else {
      createProductController.clearFields();
    }
    if (productArg == null) {
      createProductController.autoGenerateProductCode();
    }
  }

  void _fillFields(Product p) {
    final ctrl = createProductController;

    ctrl.productCodeController.text = p.productId;
    ctrl.productNameController.text = p.productName;
    ctrl.basePriceController.text = p.mrp.toString();
    ctrl.sellingPriceController.text = p.sellingPrice.toString();
    ctrl.stockController.text = p.stockQuantity.toString();
    ctrl.netWeightController.text = p.netWeight.toString();
    ctrl.manufacturingDateController.text = p.manufacturingDate;
    ctrl.expiryDateController.text = p.expiryDate;
    ctrl.ingredientsListController.text = p.ingredients;
    ctrl.isActive.value = p.status == '1';
    ctrl.descriptionController.text = p.description ?? "";

    // ✅ Auto fill category name and ID
    ctrl.selectedCategoryName.value = p.categoryName ?? '';
    // Find and set the category ID from the category name
    if (p.categoryName.isNotEmpty) {
      final selectedCategory = premiumCollectionController.premiumCollection
          .firstWhereOrNull((e) => e.categoryName == p.categoryName);
      if (selectedCategory != null) {
        ctrl.selectedCategoryId.value = selectedCategory.categoryId;
      }
    }

    ctrl.energyController.text = p.nutritionalInfo.energyKcal.toString();
    ctrl.proteinController.text = p.nutritionalInfo.proteinG.toString();
    ctrl.totalFatController.text = p.nutritionalInfo.totalFatG.toString();
    ctrl.carbohydrateController.text = p.nutritionalInfo.carbohydrateG
        .toString();
    ctrl.totalSugarController.text = p.nutritionalInfo.totalSugarG.toString();
    ctrl.saturatedFatController.text = p.nutritionalInfo.saturatedFatG
        .toString();
    ctrl.monounsaturatedFatController.text = p
        .nutritionalInfo
        .monounsaturatedFatG
        .toString();
    ctrl.polyunsaturatedFatController.text = p
        .nutritionalInfo
        .polyunsaturatedFatG
        .toString();
    ctrl.sodiumController.text = p.nutritionalInfo.sodiumMg.toString();
    ctrl.ironController.text = p.nutritionalInfo.ironMg.toString();
    ctrl.calciumController.text = p.nutritionalInfo.calciumMg.toString();
    ctrl.fiberController.text = p.nutritionalInfo.fiberG.toString();
    ctrl.vitaminCController.text = p.nutritionalInfo.vitaminCMg.toString();
    ctrl.vitaminDController.text = p.nutritionalInfo.vitaminDMcg.toString();
    ctrl.cholesterolController.text = p.nutritionalInfo.cholesterolMg
        .toString();

    if (p.productImage.isNotEmpty) ctrl.setImageUrl(p.productImage);
  }

  @override
  Widget build(BuildContext context) {
    final Product? productArg = widget.product ?? Get.arguments as Product?;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            productArg != null ? "Edit Product" : "Create New Product",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: Get.width / 22.5,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(Get.width / 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("Basic Product Information"),
                      CustomTextField(
                        label: "Product Code",
                        hint: "-",
                        controller:
                            createProductController.productCodeController,
                      ),
                      CustomTextField(
                        label: "Product Name",
                        hint: "Enter Product Name",
                        controller:
                            createProductController.productNameController,
                      ),
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
                              createProductController
                                  .selectedCategoryName
                                  .value
                                  .isEmpty
                              ? null
                              : createProductController
                                    .selectedCategoryName
                                    .value,
                          items: categories,
                          onChanged: (val) {
                            if (val != null) {
                              createProductController
                                      .selectedCategoryName
                                      .value =
                                  val;
                              final selected = premiumCollectionController
                                  .premiumCollection
                                  .firstWhereOrNull(
                                    (e) => e.categoryName == val,
                                  );
                              if (selected != null) {
                                createProductController
                                        .selectedCategoryId
                                        .value =
                                    selected.categoryId;
                              }
                            }
                          },
                          getLabel: (item) => item,
                        );
                      }),
                      CustomTextField(
                        hint: "Description",
                        label: "Description",
                        maxLines: 5,
                        controller:
                            createProductController.descriptionController,
                      ),
                      SizedBox(height: Get.height / 60),
                      _sectionTitle("Pricing & Stock Information"),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "MRP (₹)",
                        hint: "0.00",
                        controller: createProductController.basePriceController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Selling Price(₹)",
                        hint: "0.00",
                        controller:
                            createProductController.sellingPriceController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Stock Quantity",
                        hint: "0",
                        controller: createProductController.stockController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Net Weight (g)",
                        hint: "0.00",
                        controller: createProductController.netWeightController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      Text(
                        "Stock Status",
                        style: const TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: Get.height / 60),
                      Wrap(
                        spacing: Get.width / 50,
                        children: [
                          _buildStockChip(
                            label: 'In Stock',
                            color: const Color(0xff4E6B37),
                            bgColor: const Color(0xffBDDD9D),
                          ),
                          _buildStockChip(
                            label: 'Low Stock',
                            color: const Color(0xffA67014),
                            bgColor: const Color(0xffF0D996),
                          ),
                          _buildStockChip(
                            label: 'Out Of Stock',
                            color: const Color(0xffB52934),
                            bgColor: const Color(0xffEFCFD2),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height / 60),
                      UploadFileField(
                        label: "Product Image",
                        onFileSelected: (file) {
                          createProductController.setImage(file as File);
                        },
                      ),
                      SizedBox(height: Get.height / 60),
                      _sectionTitle("Manufacturing & Expiry Dates"),
                      CustomDateField(
                        label: "Manufacturing date",
                        controller:
                            createProductController.manufacturingDateController,
                        hint: "Select Date",
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDateField(
                        label: "Expiry date",
                        controller:
                            createProductController.expiryDateController,
                        hint: "Select Date",
                      ),
                      SizedBox(height: Get.height / 60),
                      _sectionTitle("Ingredients"),
                      CustomTextField(
                        label: "Ingredients List",
                        hint: "Enter Ingredients list (Separate with Commas)",
                        controller:
                            createProductController.ingredientsListController,
                      ),
                      SizedBox(height: Get.height / 60),
                      Row(
                        children: [
                          Obx(
                            () => Checkbox(
                              value: createProductController.isActive.value,
                              onChanged: (value) {
                                createProductController.isActive.value = value!;
                              },
                              activeColor: const Color(0xffF78520),
                            ),
                          ),
                          Text(
                            "Product is Active",
                            style: GoogleFonts.poppins(
                              fontSize: Get.width / 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height / 60),
                      SizedBox(
                        width: double.infinity,
                        height: Get.height / 18,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffF78520),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              bool success = false;
                              if (productArg != null) {
                                success = await createProductController
                                    .updateProduct(productArg.productId);
                              } else {
                                success = await createProductController
                                    .createProduct();
                              }
                              if (success) {
                                await productController.fetchProducts();
                                Get.back();
                              }
                            }
                          },
                          child: Text(
                            productArg != null
                                ? "Update Product"
                                : "Create Product",
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
                SizedBox(height: Get.height / 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: Get.width / 21,
          color: const Color(0xffF78520),
        ),
      ),
    );
  }

  Widget _buildStockChip({
    required String label,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width / 25,
        vertical: Get.height / 80,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: Get.width / 30,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ),
    );
  }
}
