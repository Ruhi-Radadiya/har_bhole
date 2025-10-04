// product_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../main.dart';
import '../../../routes/routes.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key});

  // Helper for a single detail field
  Widget _buildDetailField({
    required String label,
    required String value,
    int maxLines = 1,
    Color valueColor = Colors.black,
  }) {
    final double fieldHeight = maxLines > 1 ? Get.height / 10 : Get.height / 20;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xff000000),
            ),
          ),
        ),
        SizedBox(height: Get.height / 150),

        Container(
          height: fieldHeight,
          alignment: maxLines > 1 ? Alignment.topLeft : Alignment.centerLeft,
          padding: EdgeInsets.symmetric(
            horizontal: Get.width / 25,
            vertical: Get.height / 100,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffF3F7FC),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            value,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: valueColor,
                fontSize: Get.width / 30,
                fontWeight: valueColor == Colors.black
                    ? FontWeight.normal
                    : FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: Get.height / 50),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color mainOrange = Color(0xffF78520);

    return Obx(() {
      final product = productController.selectedProduct.value;

      if (product == null) {
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: Center(
            child: Text('No product selected', style: GoogleFonts.poppins()),
          ),
        );
      }

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
              child: Column(
                children: [
                  SizedBox(height: Get.height / 100),
                  Row(
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
                ],
              ),
            ),
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
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            child: Image.asset(
                              product.imageUrl,
                              width: double.infinity,
                              height: Get.height / 4,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: Get.height / 40,
                              bottom: Get.height / 40,
                              left: Get.width / 25,
                              right: Get.width / 25,
                            ),
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

                                _buildDetailField(
                                  label: 'Product Code',
                                  value: product.productCode,
                                ),

                                _buildDetailField(
                                  label: 'Stock Quantity',
                                  value: product.stockQuantity.toString(),
                                ),

                                _buildDetailField(
                                  label: 'Net Weight',
                                  value: '${product.netWeight}g',
                                ),

                                _buildDetailField(
                                  label: 'Category',
                                  value: product.category,
                                ),

                                _buildDetailField(
                                  label: 'Stock Status',
                                  value: product.stockStatus,
                                  valueColor: productController.getStatusColor(
                                    product.stockStatus,
                                  ),
                                ),

                                _buildDetailField(
                                  label: 'Selling Price',
                                  value:
                                      '₹${product.sellingPrice.toStringAsFixed(2)}',
                                  valueColor: const Color(0xff2E8755),
                                ),

                                if (product.manufacturingDate != null)
                                  _buildDetailField(
                                    label: 'Manufacturing Date',
                                    value: product.manufacturingDate!,
                                  ),

                                if (product.expiryDate != null)
                                  _buildDetailField(
                                    label: 'Expiry Date',
                                    value: product.expiryDate!,
                                  ),

                                if (product.ingredients.isNotEmpty)
                                  _buildDetailField(
                                    label: 'Ingredients',
                                    value: product.ingredients,
                                    maxLines: 3,
                                  ),

                                SizedBox(
                                  height: Get.height / 18,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.createProduct);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: mainOrange,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          12.0,
                                        ),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: Text(
                                      'Edit',
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: Get.height / 80),
                                SizedBox(
                                  height: Get.height / 18,
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Get.defaultDialog(
                                        title: 'Delete Product',
                                        middleText:
                                            'Are you sure you want to delete ${product.productName}?',
                                        textConfirm: 'Yes',
                                        textCancel: 'No',
                                        confirmTextColor: Colors.white,
                                        onConfirm: () {
                                          productController.deleteProduct(
                                            product.id,
                                          );
                                        },
                                      );
                                    },
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                        color: mainOrange,
                                        width: 1,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          12.0,
                                        ),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: Text(
                                      'Delete',
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          color: mainOrange,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
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
    });
  }
}
