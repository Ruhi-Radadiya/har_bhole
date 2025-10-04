import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../component/textfield.dart';

class CreateProductScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  // Example controllers
  final TextEditingController productCodeController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController basePriceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final RxBool isActive = true.obs;

  final List<String> categories = ["Ring", "Necklace", "Earrings"];
  final List<String> productTypes = ["14KT", "18KT", "22KT"];
  final List<String> collections = ["Office Wear", "Party Wear", "Casual"];

  final RxString selectedCategory = "".obs;
  final RxString selectedType = "".obs;
  final RxString selectedCollection = "".obs;

  CreateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create New Product",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
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
                      controller: stockController,
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
                      controller: stockController,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: Get.height / 60),

                    Text("Stock Status", style: TextStyle(color: Colors.black)),
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
                      label: "Category Image",
                      onFileSelected: (file) {},
                    ),
                    SizedBox(height: Get.height / 60),
                    _sectionTitle("Manufacturing & Expiry Dates"),
                    SizedBox(height: Get.height / 60),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Manufacturing Date',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height / 150),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: Get.width / 25,
                            ),
                            height: Get.height / 20,
                            decoration: BoxDecoration(
                              color: const Color(0xffF3F7FC),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      hintText: 'Select Date',
                                      hintStyle: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          color: const Color(0xff858585),
                                          fontSize: Get.width / 30,
                                        ),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.calendar_today,
                                  color: const Color(0xff858585),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height / 50),
                      ],
                    ),
                    SizedBox(height: Get.height / 60),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expiry date',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height / 150),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: Get.width / 25,
                            ),
                            height: Get.height / 20,
                            decoration: BoxDecoration(
                              color: const Color(0xffF3F7FC),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      hintText: 'Select Date',
                                      hintStyle: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          color: const Color(0xff858585),
                                          fontSize: Get.width / 30,
                                        ),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.calendar_today,
                                  color: const Color(0xff858585),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height / 50),
                      ],
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
                            fontSize: 15,
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
                            fontSize: 15,
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
                            fontSize: 16,
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
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 17,
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
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ),
    );
  }
}
