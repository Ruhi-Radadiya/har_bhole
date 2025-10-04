import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/routes.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _ProductState extends State<Product> {
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
              Container(
                width: Get.width,
                height: Get.height / 2.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [const Color(0xffF78520), const Color(0xffffffff)],
                  ),
                  image: DecorationImage(
                    image: AssetImage("asset/images/home/home_background.png"),
                    fit: BoxFit.cover,
                    opacity: 0.2,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40.0,
                        left: 20,
                        right: 20,
                        bottom: 16,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: SizedBox(
                                  height: Get.width / 20,
                                  width: Get.width / 20,
                                  child: Image.asset(
                                    "asset/images/home/location.png",
                                    color: Color(0xffF78520),
                                  ),
                                ),
                              ),
                              SizedBox(width: Get.width / 50),
                              Text(
                                "Vrajbhoomi\nNana Varachha, Surat",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.adminBottomBar);
                                },
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  child: SizedBox(
                                    height: Get.width / 20,
                                    width: Get.width / 20,
                                    child: Image.asset(
                                      "asset/images/home/person.png",
                                      color: Color(0xffF78520),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: Get.width / 50),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.shoppingCard);
                                },
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  child: SizedBox(
                                    height: Get.width / 20,
                                    width: Get.width / 20,
                                    child: Image.asset(
                                      "asset/images/home/cart.png",
                                      color: Color(0xffF78520),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Get.height / 40),
                          Text(
                            "Namkeen That Speaks Your Mood!",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            "From festive treats to daily snacks, we have something for every mood and every occasion.",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height / 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // First Button
                              ElevatedButton(
                                onPressed: () {
                                  // Action for first button
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffF78520),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: const Text(
                                  "Explore More",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                  // top: 10.0,
                  left: 20,
                  right: 20,
                  bottom: 16,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Our Delicious Product",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Color(0xff828590),
                              fontSize: 16.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          "View All",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Color(0xffF2722D),
                              fontSize: 16.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: Get.height / 30),
                    _buildFoodItemCard2(
                      imageUrl: "asset/images/home/samosa.png",
                      title: "Samosa",
                      weight: "500.00 g",
                      price: "220",
                      rating: "3.8",
                      isPremium: true,
                      onAddToCart: () {
                        print("Add to Cart tapped for Papad Poha!");
                      },
                    ),
                    SizedBox(height: Get.height / 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFoodItemCard2({
    required String imageUrl,
    required String title,
    required String weight,
    required String price,
    String rating = '4.2',
    bool isPremium = false,
    required VoidCallback onAddToCart,
  }) {
    return Container(
      width: Get.width / 1,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Get.width / 20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: Get.width / 200,
            blurRadius: Get.width / 80,
            offset: Offset(0, Get.width / 120),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(Get.width / 20),
                ),
                child: Image.asset(
                  imageUrl,
                  height: Get.height / 4,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if (isPremium)
                Positioned(
                  top: Get.height / 80,
                  right: Get.width / 30,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width / 25,
                      vertical: Get.height / 200,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE53935),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      "Spicy",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(Get.width / 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Get.width / 40,
                        vertical: Get.height / 250,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4F6B1F),
                        borderRadius: BorderRadius.circular(Get.width / 60),
                      ),
                      child: Row(
                        children: [
                          Text(
                            rating,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Get.width / 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: Get.width / 100),
                          Icon(
                            Icons.star,
                            color: Colors.white,
                            size: Get.width / 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height / 150),
                Text(
                  weight,
                  style: TextStyle(fontSize: 13.0, color: Color(0xff666666)),
                ),
                SizedBox(height: Get.height / 150),

                Text(
                  "₹$price",
                  style: TextStyle(
                    fontSize: Get.width / 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: Get.height / 90),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onAddToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF78520),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Get.width / 30),
                      ),
                      padding: EdgeInsets.symmetric(vertical: Get.height / 90),
                    ),
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
