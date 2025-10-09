import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../component/food_card.dart';
import '../../component/frenchies_food_card.dart';

class Frenchies extends StatelessWidget {
  Frenchies({super.key});

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
      child: SafeArea(
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
                              borderRadius: BorderRadius.circular(
                                Get.width / 27,
                              ),
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
                  Row(
                    children: [
                      Text(
                        "Our Premium Collection",
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
                  SizedBox(height: Get.height / 50),
                  SizedBox(
                    height: Get.height / 5,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: foodImages.length,
                      physics: const BouncingScrollPhysics(),

                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: Get.width / 42),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                foodImages[index],
                                fit: BoxFit.cover,
                                height: Get.height / 7,
                              ),
                              SizedBox(height: 4),
                              Text(
                                foodNames[index],
                                style: TextStyle(
                                  fontSize: Get.width / 28,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        SmallFoodItemCard(
                          imageUrl: 'asset/images/home/samosa.png',
                          title: 'Bihari Samosa',
                          timeDistance: '20 - 25 mins',
                          offerBadgeText: 'FLAT ₹50 OFF',
                          rating: '4.7',
                        ),
                        SizedBox(width: Get.width / 100),
                        SmallFoodItemCard(
                          imageUrl: 'asset/images/home/khaman.png',
                          title: 'Bihari Samosa',
                          timeDistance: '20 - 25 mins',
                          offerBadgeText: 'FLAT ₹50 OFF',
                          rating: '4.7',
                        ),
                      ],
                    ),
                  ),
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
          ),
        ),
      ),
    );
  }
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
