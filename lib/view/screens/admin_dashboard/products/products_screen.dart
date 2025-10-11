// products_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/view/component/textfield.dart';

import '../../../../main.dart';
import '../../../../model/product_model/product_model.dart';
import '../../../../routes/routes.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color mainOrange = Color(0xffF78520);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: Get.height / 25,
                  left: Get.width / 25,
                  right: Get.width / 25,
                  bottom: Get.height / 50,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                    colors: [Color(0xffFFE1C7), Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 1.0],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height / 100),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: Color(0xffFAD6B5),
                            shape: BoxShape.circle,
                          ),
                          child: SizedBox(
                            height: Get.width / 15,
                            width: Get.width / 15,
                            child: Image.asset('asset/icons/users_icon.png'),
                          ),
                        ),
                        SizedBox(width: Get.width / 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Products',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: Get.width / 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: Get.height / 200),
                            Text(
                              'Manage all Products',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: Get.width / 28,
                                  color: Color(0xff4A4541),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height / 50),
                    SizedBox(
                      height: Get.height / 18,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.createProduct);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffF78520),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Add Products',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
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
              Padding(
                padding: EdgeInsets.only(
                  left: Get.width / 18,
                  right: Get.width / 18,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height / 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'All Products',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: Get.width / 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff747784),
                            ),
                          ),
                        ),
                        Text(
                          'View All',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: Get.width / 26,
                              fontWeight: FontWeight.w500,
                              color: mainOrange,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height / 50),
                    Container(
                      padding: EdgeInsets.all(Get.width / 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          CustomTextField(
                            hint: "Search Products",
                            icon: Icons.search,
                            onChanged: (value) {
                              productController.searchProducts(value);
                            },
                          ),
                          SizedBox(height: Get.height / 80),
                          const Divider(height: 1, color: Color(0xffF2F3F5)),
                          Obx(() {
                            if (productController.isLoading.value) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (productController.errorMessage.isNotEmpty) {
                              return Center(
                                child: Text(
                                  productController.errorMessage.value,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              );
                            }

                            if (productController.filteredProducts.isEmpty) {
                              return const Center(
                                child: Text('No products found'),
                              );
                            }

                            return Column(
                              children: productController.filteredProducts.map((
                                product,
                              ) {
                                return Column(
                                  children: [
                                    _buildCategoryTile(
                                      product: product,
                                      title: product.productName,
                                      subtitle:
                                          product.variationValue.isNotEmpty
                                          ? product.variationValue
                                          : 'No variation',
                                      status: product.status == '1'
                                          ? 'Active'
                                          : 'INActive',
                                      statusColor: product.status == '1'
                                          ? const Color(0xffDCE1D7)
                                          : const Color(0xffEFCFD2),
                                      statusTextColor: product.status == '1'
                                          ? const Color(0xff4E6B37)
                                          : const Color(0xffAD111E),
                                    ),
                                    const Divider(
                                      height: 1,
                                      color: Color(0xffF2F3F5),
                                    ),
                                  ],
                                );
                              }).toList(),
                            );
                          }),
                        ],
                      ),
                    ),
                    SizedBox(height: Get.height / 15),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTile({
    required String title,
    required String subtitle,
    required String status,
    required Color statusColor,
    required Color statusTextColor,
    required Product? product,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height / 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Wrap left part in Flexible with Row
          Flexible(
            child: Row(
              children: [
                Container(
                  width: Get.width / 8,
                  height: Get.width / 8,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15.0),
                    image: const DecorationImage(
                      image: AssetImage('asset/images/about/jalebi.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: Get.width / 30),
                // Expanded ensures text fits remaining space
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: Get.width / 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        subtitle,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: Get.width / 34.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Right part fixed size
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: Get.width / 36,
                      fontWeight: FontWeight.bold,
                      color: statusTextColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height / 200),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.productDetails, arguments: product);
                },
                child: Text(
                  'View Details',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: Get.width / 36,
                      color: const Color(0xff2A86D1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
