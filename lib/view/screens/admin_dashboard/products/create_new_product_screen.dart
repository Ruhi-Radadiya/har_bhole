import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/main.dart';

import '../../../component/textfield.dart';

class CreateProductScreen extends StatefulWidget {
  CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final List<String> categories = ["0", "1", "2"];

  Future<void> selectManufacturingDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: createProductController.selectedManufacturingDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      createProductController.selectedManufacturingDate.value = picked;
      createProductController.manufacturingDateController.text =
          "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
    }
  }

  Future<void> selectExpiryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: createProductController.selectedExpiryDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      createProductController.selectedExpiryDate.value = picked;
      createProductController.expiryDateController.text =
          "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
    }
  }

  void _toggleTag(String tag) {
    createProductController.toggleTag(tag);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Create New Product",
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
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(Get.width / 25), // inner padding
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20), // rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // shadow color
                        blurRadius: 10,
                        offset: Offset(0, 5), // vertical offset
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("Basic Product Information"),
                      CustomTextField(
                        label: "Product Code (8-digit)",
                        hint: "Enter Product Code",
                        controller:
                            createProductController.productCodeController,
                        validator: (v) => v!.isEmpty ? "Required" : null,
                      ),
                      CustomTextField(
                        label: "Product Name",
                        hint: "Enter Product Name",
                        controller:
                            createProductController.productNameController,
                        validator: (v) => v!.isEmpty ? "Required" : null,
                      ),
                      Obx(
                        () => CustomDropdownField<String>(
                          label: "Category",
                          value:
                              createProductController
                                  .selectedCategory
                                  .value
                                  .isEmpty
                              ? null
                              : createProductController.selectedCategory.value,
                          items: categories,
                          onChanged: (val) =>
                              createProductController.selectedCategory.value =
                                  val!,
                          getLabel: (item) => item,
                        ),
                      ),
                      CustomTextField(
                        hint: "Description",
                        label: "Description",
                        maxLines: 5,
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
                        label: "Selling Prince(₹)",
                        hint: "Enter Stock",
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
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: Get.height / 60),
                      Wrap(
                        spacing: Get.width / 50,
                        children: [
                          _buildStockChip(
                            label: 'In Stock',
                            color: Color(0xff4E6B37),
                            bgColor: Color(0xffBDDD9D),
                          ),
                          _buildStockChip(
                            label: 'Low Stock',
                            color: Color(0xffA67014),
                            bgColor: Color(0xffF0D996),
                          ),
                          _buildStockChip(
                            label: 'Out Of Stock',
                            color: Color(0xffB52934),
                            bgColor: Color(0xffEFCFD2),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height / 60),
                      UploadFileField(
                        label: "Product Image",
                        onFileSelected: (file) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      _sectionTitle("Manufacturing & Expiry Dates"),
                      SizedBox(height: Get.height / 60),
                      CustomDateField(
                        label: "Manufacturing date",
                        controller:
                            createProductController.manufacturingDateController,
                        onTap: () => selectManufacturingDate(context),
                        hint: "Select Date",
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDateField(
                        label: "Expiry date",
                        controller:
                            createProductController.expiryDateController,
                        onTap: () => selectExpiryDate(context),
                        hint: "Select Date",
                      ),
                      SizedBox(height: Get.height / 60),
                      _sectionTitle("Ingredients"),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Ingredients List",
                        hint: "Enter Ingredients list (Separate with Commas)",
                        controller:
                            createProductController.ingredientsListController,
                      ),
                      SizedBox(height: Get.height / 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _sectionTitle("Nutritional (per 100g)"),
                          Text(
                            "Edit",
                            style: TextStyle(
                              color: Color(0xffF26E27),
                              fontWeight: FontWeight.bold,
                              fontSize: Get.width / 24,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Energy(kcal)",
                        hint: "Enter Value",
                        controller: createProductController.energyController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Protein(g)",
                        hint: "Enter Value",
                        controller: createProductController.proteinController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Total Fat(g)",
                        hint: "Enter Value",
                        controller: createProductController.totalFatController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Carbohydrate(g)",
                        hint: "Enter Value",
                        controller:
                            createProductController.carbohydrateController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Total Sugar(g)",
                        hint: "Enter Value",
                        controller:
                            createProductController.totalSugarController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Saturated Fat(g)",
                        hint: "Enter Value",
                        controller:
                            createProductController.saturatedFatController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Monounsaturated Fat(g)",
                        hint: "Enter Value",
                        controller: createProductController
                            .monounsaturatedFatController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Polyunsaturated Fat(g)",
                        hint: "Enter Value",
                        controller: createProductController
                            .polyunsaturatedFatController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Sodium(mg)",
                        hint: "Enter Value",
                        controller: createProductController.sodiumController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Iron(mg)",
                        hint: "Enter Value",
                        controller: createProductController.ironController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Calcium(mg)",
                        hint: "Enter Value",
                        controller: createProductController.calciumController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Fiber(g)",
                        hint: "Enter Value",
                        controller: createProductController.fiberController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Vitamin C(mg)",
                        hint: "Enter Value",
                        controller: createProductController.vitaminCController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Vitamin D(mcg)",
                        hint: "Enter Value",
                        controller: createProductController.vitaminDController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Cholesterol(mg)",
                        hint: "Enter Value",
                        controller:
                            createProductController.cholesterolController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      _sectionTitle("Product Tags"),
                      SizedBox(height: Get.height / 60),
                      _buildProductTagFlow(
                        tags: createProductController.productTags,
                        selectedTags: createProductController.selectedTags,
                        onTagTap: (tag) =>
                            createProductController.toggleTag(tag),
                      ),

                      SizedBox(height: Get.height / 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _sectionTitle("Product Variations"),
                          Text(
                            "Edit",
                            style: TextStyle(
                              color: Color(0xffF26E27),
                              fontWeight: FontWeight.bold,
                              fontSize: Get.width / 24,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Variation Name",
                        hint: "e.g., size, color",

                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Variation Value",
                        hint: "e.g., large, Red",

                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Price Adjustment (₹)",
                        hint: "0.00",

                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "SKU",
                        hint: "SKU",

                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: Get.height / 5,
                            height: Get.height / 18,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                side: BorderSide(
                                  color: Color(0xffF78520),
                                  width: 2,
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                "+ Add Varients",
                                style: GoogleFonts.poppins(
                                  fontSize: Get.width / 30,
                                  color: Color(0xffF78520),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
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
                              activeColor: Color(0xffF78520),
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
                              final success = await createProductController
                                  .createProduct();
                              if (success) {
                                _formKey.currentState!.reset();
                                createProductController.clearFields();
                                Get.back(); // ✅ go back after success
                              }
                            }
                          },
                          child: Text(
                            "Create Product",
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

  Widget _buildProductTagFlow({
    required List<String> tags,
    required RxSet<String> selectedTags,
    Function(String tag)? onTagTap,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double spacing = 8.0;
        final double totalSpacing = spacing * 2; // 3 items => 2 spaces
        final double tagWidth = (constraints.maxWidth - totalSpacing) / 3;
        const double tagHeight = 40.0;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: tags.map((tag) {
            // Wrap each tag in Obx instead of the whole LayoutBuilder
            return Obx(() {
              final isSelected = selectedTags.contains(tag);
              final theme = ThemeData.light();

              return GestureDetector(
                onTap: onTagTap != null ? () => onTagTap(tag) : null,
                child: Container(
                  width: tagWidth,
                  height: tagHeight,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? theme.primaryColor.withOpacity(0.1)
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Text(
                    tag,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isSelected ? theme.primaryColor : Colors.black87,
                    ),
                  ),
                ),
              );
            });
          }).toList(),
        );
      },
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
          color: Color(0xffF78520),
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
