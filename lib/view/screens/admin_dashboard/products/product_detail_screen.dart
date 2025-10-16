import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../main.dart';
import '../../../../model/product_model/product_model.dart';
import '../../../component/textfield.dart';
import 'create_new_product_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color mainOrange = Color(0xffF78520);

    final Product product = Get.arguments as Product;

    return Scaffold(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Get.back(),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(minWidth: Get.width / 15),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Product Details',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Get.width / 15),
              ],
            ),
          ),

          // --- Main Content ---
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: Get.height / 50),
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
                        // --- Product Image ---
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          child: Image.network(
                            product.productImage,
                            width: double.infinity,
                            height: Get.height / 4,
                            fit: BoxFit.cover,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(Get.width / 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.productName,
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height / 30),

                              // --- Main Product Details using CustomTextField ---
                              CustomTextField(
                                label: 'Product Code',
                                hint: product.productId,
                                isReadOnly: true,
                              ),
                              CustomTextField(
                                label: 'Variation',
                                hint: product.variationValue.isNotEmpty
                                    ? product.variationValue
                                    : 'No variation',
                                isReadOnly: true,
                              ),
                              CustomTextField(
                                label: 'Status',
                                hint: product.status == '1'
                                    ? 'Active'
                                    : 'Inactive',
                                isReadOnly: true,
                              ),
                              CustomTextField(
                                label: 'Category',
                                hint: product.categoryName,
                                isReadOnly: true,
                              ),
                              CustomTextField(
                                label: 'Selling Price',
                                hint: product.sellingPrice.toString(),
                                isReadOnly: true,
                              ),
                              CustomTextField(
                                label: 'Stock Quantity',
                                hint: product.stockQuantity.toString(),
                                isReadOnly: true,
                              ),

                              const SizedBox(height: 20),

                              // --- Action Buttons ---
                              SizedBox(
                                height: Get.height / 18,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Navigate to CreateOrUpdateProductScreen with the product to edit
                                    Get.to(
                                      () => CreateProductScreen(),
                                      arguments: product,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: mainOrange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  child: const Text(
                                    'Edit',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height / 80),
                              SizedBox(
                                height: Get.height / 18,
                                width: double.infinity,
                                child: OutlinedButton(
                                  onPressed: () async {
                                    bool confirmed = await Get.defaultDialog(
                                      title: "Confirm Delete",
                                      middleText:
                                          "Are you sure you want to delete this product?",
                                      textConfirm: "Yes",
                                      textCancel: "No",
                                      onConfirm: () => Get.back(result: true),
                                      onCancel: () => Get.back(result: false),
                                    );

                                    if (confirmed == true) {
                                      await deleteProductController
                                          .deleteProduct(product.productId);
                                      // Optionally refresh the product list after deletion
                                      productController.fetchProducts();
                                      Get.back(); // Go back to product list screen
                                    }
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: const Color(0xffF78520),
                                      width: 1,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(color: Color(0xffF78520)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Get.height / 30),
        ],
      ),
    );
  }
}
