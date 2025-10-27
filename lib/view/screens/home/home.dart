import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../main.dart';
import '../../../routes/routes.dart';
import '../../component/food_card.dart';

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
                                    Text(
                                      "Hammes Freeway, Konop...",
                                      style: TextStyle(
                                        fontSize: Get.width / 30,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                GestureDetector(
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
                                ),
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
                                    Image(
                                      image: AssetImage(
                                        "asset/icons/microphone.png",
                                      ),
                                      height: Get.width / 24,
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
                    RestaurantFoodCard(
                      imageUrl: 'asset/images/home/samosa.png',
                      title: 'Bihari Samosa',
                      subDetails: '15 - 20 mins  |  1.2 km',
                      offerText: '40% OFF up to ₹80',
                      rating: '4.7',
                      costPerOne: '₹120 for one',
                      onTap: () {
                        log("TAPPED");
                      },
                    ),
                    SizedBox(height: Get.height / 50),
                    RestaurantFoodCard(
                      imageUrl: 'asset/images/home/samosa.png',
                      title: 'Bihari Samosa',
                      subDetails: '15 - 20 mins  |  1.2 km',
                      offerText: '40% OFF up to ₹80',
                      rating: '4.7',
                      costPerOne: '₹120 for one',
                      onTap: () {},
                    ),
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
