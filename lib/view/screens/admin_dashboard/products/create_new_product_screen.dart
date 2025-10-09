import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../component/textfield.dart';

class CreateProductScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  // Example controllers
  final TextEditingController productCodeController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController basePriceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController netWeightController = TextEditingController();
  final TextEditingController sellingPriceController = TextEditingController();
  final TextEditingController manufacturingDateController =
      TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController ingredientsListController =
      TextEditingController();

  final RxBool isActive = true.obs;

  final List<String> categories = ["Snack", "Sweet", "Farsan"];
  var selectedManufacturingDate = DateTime.now().obs;
  var selectedExpiryDate = DateTime.now().obs;

  final RxString selectedCategory = "".obs;
  final RxString selectedType = "".obs;
  final RxString selectedCollection = "".obs;
  Future<void> selectManufacturingDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedManufacturingDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      selectedManufacturingDate.value = picked;
      manufacturingDateController.text =
          "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
    }
  }

  Future<void> selectExpiryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedExpiryDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      selectedExpiryDate.value = picked;
      expiryDateController.text =
          "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
    }
  }

  CreateProductScreen({super.key});

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
                        controller: productCodeController,
                        validator: (v) => v!.isEmpty ? "Required" : null,
                      ),
                      CustomTextField(
                        label: "Product Name",
                        hint: "Enter Product Name",
                        controller: productNameController,
                        validator: (v) => v!.isEmpty ? "Required" : null,
                      ),
                      Obx(
                        () => CustomDropdownField<String>(
                          label: "Category",
                          value: selectedCategory.value.isEmpty
                              ? null
                              : selectedCategory.value,
                          items: categories,
                          onChanged: (val) => selectedCategory.value = val!,
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
                        controller: basePriceController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "Selling Prince(₹)",
                        hint: "Enter Stock",
                        controller: sellingPriceController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "Stock Quantity",
                        hint: "0",
                        controller: stockController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "Net Weight (g)",
                        hint: "0.00",
                        controller: netWeightController,
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
                        controller: manufacturingDateController,
                        onTap: () => selectManufacturingDate(context),
                        hint: "Select Date",
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDateField(
                        label: "Expiry date",
                        controller: expiryDateController,
                        onTap: () => selectExpiryDate(context),
                        hint: "Select Date",
                      ),
                      SizedBox(height: Get.height / 60),
                      _sectionTitle("Ingredients"),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Ingredients List",
                        hint: "Enter Ingredients list (Separate with Commas)",
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
                      CustomDropdownField(
                        label: "Energy(kcal)",
                        hint: "Enter Value",
                        items: [1, 2, 3],
                        value: (),
                        getLabel: (item) => item.toString(),
                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField(
                        label: "Protein(g)",
                        hint: "Enter Value",
                        items: [1, 2, 3],
                        value: (),
                        getLabel: (item) => item.toString(),
                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField(
                        label: "Total Fat(g)",
                        hint: "Enter Value",
                        items: [1, 2, 3],
                        value: (),
                        getLabel: (item) => item.toString(),
                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField(
                        label: "Carbohydrate(g)",
                        hint: "Enter Value",
                        items: [1, 2, 3],
                        value: (),
                        getLabel: (item) => item.toString(),
                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField(
                        label: "Total Sugar(g)",
                        hint: "Enter Value",
                        items: [1, 2, 3],
                        value: (),
                        getLabel: (item) => item.toString(),
                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField(
                        label: "Saturated Fat(g)",
                        hint: "Enter Value",
                        items: [1, 2, 3],
                        value: (),
                        getLabel: (item) => item.toString(),
                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField(
                        label: "Monounsaturated Fat(g)",
                        hint: "Enter Value",
                        items: [1, 2, 3],
                        value: (),
                        getLabel: (item) => item.toString(),
                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField(
                        label: "Polyunsaturated Fat(g)",
                        hint: "Enter Value",
                        items: [1, 2, 3],
                        value: (),
                        getLabel: (item) => item.toString(),
                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField(
                        label: "Sodium(mg)",
                        hint: "Enter Value",
                        items: [1, 2, 3],
                        value: (),
                        getLabel: (item) => item.toString(),
                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField(
                        label: "Iron(mg)",
                        hint: "Enter Value",
                        items: [1, 2, 3],
                        value: (),
                        getLabel: (item) => item.toString(),
                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField(
                        label: "Calcium(mg)",
                        hint: "Enter Value",
                        items: [1, 2, 3],
                        value: (),
                        getLabel: (item) => item.toString(),
                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField(
                        label: "Fiber(g)",
                        hint: "Enter Value",
                        items: [1, 2, 3],
                        value: (),
                        getLabel: (item) => item.toString(),
                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField(
                        label: "Cholesterol(mg)",
                        hint: "Enter Value",
                        items: [1, 2, 3],
                        value: (),
                        getLabel: (item) => item.toString(),
                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField(
                        label: "Vitamin C(mg)",
                        hint: "Enter Value",
                        items: [1, 2, 3],
                        value: (),
                        getLabel: (item) => item.toString(),
                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField(
                        label: "Vitamin D(mcg)",
                        hint: "Enter Value",
                        items: [1, 2, 3],
                        value: (),
                        getLabel: (item) => item.toString(),
                        onChanged: (val) {},
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
                      CustomDropdownField(
                        label: "Variation Name",
                        hint: "e.g., size, color",
                        items: [1, 2, 3],
                        value: (),
                        getLabel: (item) => item.toString(),
                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField(
                        label: "Variation Value",
                        hint: "e.g., large, Red",
                        items: [1, 2, 3],
                        value: (),
                        getLabel: (item) => item.toString(),
                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField(
                        label: "Price Adjustment (₹)",
                        hint: "0.00",
                        items: [1, 2, 3],
                        value: (),
                        getLabel: (item) => item.toString(),
                        onChanged: (val) {},
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField(
                        label: "SKU",
                        hint: "SKU",
                        items: [1, 2, 3],
                        value: (),
                        getLabel: (item) => item.toString(),
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
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // handle submit
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
