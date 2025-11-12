import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../main.dart';
import '../../../model/product_model/product_model.dart';
import '../../component/food_card.dart';
import '../../component/frenchies_food_card.dart';
import '../products/products.dart';

class Frenchies extends StatelessWidget {
  Frenchies({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> foodImages = [
    'asset/images/home/dahipuri.png',
    'asset/images/home/khaman_2.png',
    'asset/images/home/jalebi_2.png',
    'asset/images/home/dahipuri.png',
  ];
  final List<String> foodNames = ['Dahipuri', 'Khaman', 'Jalebi', 'Dahipuri'];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfffefefe),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Get.width / 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height / 50),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: Get.width / 40,
                          bottom: Get.height / 100,
                        ),
                        child: Container(
                          height: Get.height / 16,
                          padding: EdgeInsets.symmetric(
                            horizontal: Get.width / 25,
                            vertical: Get.height / 100,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(Get.width / 27),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                blurRadius: 6,
                                spreadRadius: 0,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                "asset/icons/search.png",
                                height: Get.width / 22,
                              ),
                              SizedBox(width: Get.width / 40),
                              Expanded(
                                child: TextField(
                                  style: GoogleFonts.poppins(
                                    fontSize: Get.width / 28,
                                    color: Colors.black87,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Search “papad poha”',
                                    hintStyle: GoogleFonts.poppins(
                                      fontSize: Get.width / 28,
                                      color: Colors.grey.shade600,
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                ),
                              ),
                              Image.asset(
                                "asset/icons/microphone.png",
                                height: Get.width / 22,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width / 20),
                    Image.asset(
                      "asset/images/home/3_dot.png",
                      height: Get.width / 15,
                    ),
                  ],
                ),
                SizedBox(height: Get.height / 50),
                Text(
                  "Our Premium Collection",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: Get.width / 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: Get.height / 50),
                // Obx(() {
                //   if (premiumCollectionController.isLoading.value) {
                //     return SizedBox(
                //       height: Get.height / 7,
                //       child: Center(child: CircularProgressIndicator()),
                //     );
                //   }
                //   return SizedBox(
                //     height: Get.height / 7,
                //     child: ListView.builder(
                //       scrollDirection: Axis.horizontal,
                //       itemCount: premiumCollectionController
                //           .premiumCollection
                //           .length,
                //       physics: const BouncingScrollPhysics(),
                //       padding: EdgeInsets.symmetric(
                //         horizontal: Get.width / 33,
                //       ),
                //       itemBuilder: (context, index) {
                //         final category = premiumCollectionController
                //             .premiumCollection[index];
                //         return GestureDetector(
                //           onTap: () {
                //             Get.to(
                //               Products(defaultType: category.categoryName),
                //             );
                //           },
                //           child: Padding(
                //             padding: EdgeInsets.only(right: Get.width / 42),
                //             child: Image.network(
                //               category.categoryImage,
                //               width: Get.width / 4,
                //               fit: BoxFit.cover,
                //             ),
                //           ),
                //         );
                //       },
                //     ),
                //   );
                // }),
                SizedBox(height: Get.height / 40),
                Row(
                  children: [
                    Text(
                      "Our Exclusive Frenchie's...",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: Get.width / 21,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "View All >",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Color(0XFFF26E27),
                          fontSize: Get.width / 33,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height / 40),
                Obx(() {
                  if (productController.isLoading.value) {
                    return SizedBox(
                      height: Get.height / 7,
                      child: const Center(child: CircularProgressIndicator()),
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

                  final products = productController.productList;
                  if (products.isEmpty) {
                    return const Center(child: Text("No products available"));
                  }

                  // 🔹 Shuffle list and take 7 random products
                  final randomProducts = List<Product>.from(products)
                    ..shuffle();
                  final limitedProducts = randomProducts.take(7).toList();

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: Get.width / 50),
                    child: Row(
                      children: limitedProducts.map((product) {
                        return Padding(
                          padding: EdgeInsets.only(right: Get.width / 100),
                          child: SmallFoodItemCard(
                            imageUrl:
                                // product.productImage ??
                                'asset/images/home/samosa.png',
                            title: product.productName,
                            timeDistance:
                                '20 - 25 mins', // you can replace with dynamic data later
                            offerBadgeText: 'FLAT ₹50 OFF',
                            rating: '4.0',
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }),
                SizedBox(height: Get.height / 40),
                Row(
                  children: [
                    Text(
                      "All Products",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: Get.width / 21,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "View All >",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Color(0XFFF26E27),
                          fontSize: Get.width / 33,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height / 40),
                Obx(() {
                  if (productController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (productController.errorMessage.isNotEmpty) {
                    return Center(
                      child: Text(
                        productController.errorMessage.value,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  final products = productController.productList;
                  if (products.isEmpty) {
                    return const Center(child: Text("No products available"));
                  }
                  final shuffled = List<Product>.from(products)..shuffle();
                  final limitedProducts = shuffled.take(7).toList();

                  return Column(
                    children: limitedProducts.map((product) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: Get.height / 50),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(Products(defaultType: product.categoryName));
                          },
                          child: RestaurantFoodCard(
                            imageUrl:
                                // product.productImage ??
                                'asset/images/home/samosa.png',
                            title: product.productName,
                            subDetails: product.categoryName,
                            offerText: '',
                            rating: '4.0',
                            costPerOne: '₹${product.sellingPrice} for one',
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
