import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/login_controller.dart';
import '../../../main.dart';
import '../../../model/product_model/product_model.dart';
import '../../../routes/routes.dart';
import '../../component/food_card.dart';
import '../products/products.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
final List<String> foodImages = [
  'asset/images/home/dahipuri.png',
  'asset/images/home/khaman_2.png',
  'asset/images/home/jalebi_2.png',
  'asset/images/home/dahipuri.png',
];
final List<String> collectionTypes = [
  'Sweet',
  'Hot Snacks',
  'Namkeen',
  'Sweet',
];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfffefefe),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() {
                final banner = bannerController.banners.isNotEmpty
                    ? bannerController.banners.first
                    : null;
                return Container(
                  width: Get.width,
                  height: Get.height / 1.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Get.width / 15),
                      bottomRight: Radius.circular(Get.width / 15),
                    ),
                    image: DecorationImage(
                      image: banner != null
                          ? NetworkImage(banner.imageUrl)
                          : const AssetImage(
                                  "asset/images/home/diwali_festival_background.png",
                                )
                                as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: Get.height / 20,
                          left: Get.width / 20,
                          right: Get.width / 20,
                          bottom: Get.height / 50,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: Get.width / 9,
                                  width: Get.width / 9,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      Get.width / 25,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 2,
                                        spreadRadius: 0,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Image.asset(
                                    "asset/images/home/location.png",
                                    color: Color(0xffF78520),
                                    scale: Get.width / 120,
                                  ),
                                ),
                                SizedBox(width: Get.width / 50),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Work",
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontSize: Get.width / 26,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          size: Get.width / 20,
                                        ),
                                      ],
                                    ),
                                    Obx(
                                      () => Text(
                                        locationController.currentAddress.value,
                                        style: TextStyle(
                                          fontSize: Get.width / 30,
                                          fontWeight: FontWeight.w900,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                // GestureDetector(
                                //   onTap: () {
                                //     Get.toNamed(Routes.adminBottomBar);
                                //   },
                                //   child: Container(
                                //     height: Get.width / 9.3,
                                //     width: Get.width / 9.3,
                                //     decoration: BoxDecoration(
                                //       color: Colors.white,
                                //       borderRadius: BorderRadius.circular(
                                //         Get.width / 25,
                                //       ),
                                //       image: DecorationImage(
                                //         image: AssetImage(
                                //           "asset/images/person_image.jpg",
                                //         ),
                                //         fit: BoxFit.cover,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                Obx(() {
                                  final userRole =
                                      loginController.userRole.value;
                                  if (userRole != UserRole.admin) {
                                    return const SizedBox.shrink();
                                  }
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.adminBottomBar);
                                    },
                                    child: Container(
                                      height: Get.width / 9.3,
                                      width: Get.width / 9.3,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                          Get.width / 25,
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage(
                                            "asset/images/person_image.jpg",
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                            SizedBox(height: Get.height / 200),
                            Padding(
                              padding: EdgeInsets.only(
                                top: Get.width / 40,
                                bottom: Get.height / 100,
                              ),
                              child: Container(
                                width: Get.width,
                                height: Get.height / 16,
                                padding: EdgeInsets.symmetric(
                                  horizontal: Get.width / 25,
                                  vertical: Get.height / 100,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    Get.width / 27,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.7),
                                      blurRadius: 3,
                                      spreadRadius: 0,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                        "asset/icons/search.png",
                                      ),
                                      height: Get.width / 25,
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
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: Get.width / 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
              Padding(
                padding: EdgeInsets.all(Get.width / 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    //       child: const Center(
                    //         child: CircularProgressIndicator(),
                    //       ),
                    //     );
                    //   }
                    //
                    //   return SizedBox(
                    //     height:
                    //         Get.height /
                    //         5.5, // slightly increased height to fit text
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
                    //
                    //         return GestureDetector(
                    //           onTap: () {
                    //             Get.to(
                    //               () => Products(
                    //                 defaultType: collectionTypes[index],
                    //               ),
                    //             );
                    //           },
                    //           child: Padding(
                    //             padding: EdgeInsets.only(right: Get.width / 42),
                    //             child: Column(
                    //               children: [
                    //                 Image.network(
                    //                   category.categoryImage,
                    //                   width: Get.width / 4,
                    //                   height: Get.height / 9,
                    //                   fit: BoxFit.cover,
                    //                 ),
                    //                 SizedBox(height: Get.height / 50),
                    //                 SizedBox(
                    //                   width: Get.width / 4,
                    //                   child: Text(
                    //                     category.categoryName ?? '',
                    //                     textAlign: TextAlign.center,
                    //                     style: TextStyle(
                    //                       fontSize: 12,
                    //                       fontWeight: FontWeight.w500,
                    //                       color: Colors.black,
                    //                     ),
                    //                     overflow: TextOverflow.ellipsis,
                    //                   ),
                    //                 ),
                    //               ],
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
                          "Our Delicious Product",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: Get.width / 20,
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
                        return const Center(
                          child: Text("No products available"),
                        );
                      }
                      final shuffled = List<Product>.from(products)..shuffle();
                      final limitedProducts = shuffled.take(7).toList();

                      return Column(
                        children: limitedProducts.map((product) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: Get.height / 50),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(
                                  Products(defaultType: product.categoryName),
                                );
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
            ],
          ),
        ),
      ),
    );
  }
}
