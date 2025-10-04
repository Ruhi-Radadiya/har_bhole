import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/routes.dart';
import '../../component/textfield.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Get.width / 16,
                                    vertical: Get.height / 66,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: const Text(
                                  "Grab Now",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              SizedBox(width: Get.width / 50),
                              // Second Button
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffFCE4CE),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Get.width / 16,
                                    vertical: Get.height / 66,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: BorderSide(
                                      color: Color(0xffF78520),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  "Learn More",
                                  style: TextStyle(
                                    color: Colors.black,
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
                padding: EdgeInsets.only(
                  // top: 10.0,
                  left: Get.width / 20,
                  right: Get.width / 20,
                  bottom: Get.height / 50,
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
                    SizedBox(height: Get.height / 50),
                    FoodItemCard(
                      imageUrl: "asset/images/home/khaman.png",
                      title: "Om Har Bhole Special",
                      subtitle: "special dedicated to lord shiva",
                      onExploreMore: () {
                        print("Explore More tapped!");
                      },
                    ),
                    SizedBox(height: Get.height / 20),
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
                    SizedBox(height: Get.height / 50),
                    FoodItemCard2(
                      imageUrl: "asset/images/home/poha.png",
                      title: "Papad Poha",
                      weight: "250.00 g",
                      price: "110",
                      rating: "4.2",
                      isPremium: true,
                      onAddToCart: () {
                        print("Add to Cart tapped for Papad Poha!");
                      },
                    ),
                    SizedBox(height: Get.height / 30),
                    FoodItemCard2(
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
                    Container(
                      padding: EdgeInsets.all(Get.width / 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            spreadRadius: 6,
                            blurRadius: 15,
                            offset: Offset(0, Get.width / 100),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Contact Us",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Text(
                              "Have questions? We'd love to hear from you. Send us a message and we'll respond as soon as possible.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11.5,
                                color: Colors.grey[600],
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: Get.height / 25),
                            CustomTextField(
                              hint: "Enter Your Name",
                              fillColor: Color(0xffF7F3F1),
                            ),
                            SizedBox(height: Get.height / 50),
                            CustomTextField(
                              hint: "Enter Your Email",
                              keyboardType: TextInputType.emailAddress,
                              fillColor: Color(0xffF7F3F1),
                            ),
                            SizedBox(height: Get.height / 50),
                            CustomTextField(
                              hint: "Enter Your Phone Number",
                              keyboardType: TextInputType.phone,
                              fillColor: Color(0xffF7F3F1),
                            ),
                            SizedBox(height: Get.height / 50),
                            CustomTextField(
                              hint: "Type Your Message......",
                              keyboardType: TextInputType.name,
                              fillColor: Color(0xffF7F3F1),
                              maxLines: 6,
                            ),
                            SizedBox(height: Get.height / 30),
                            _buildPrimaryButton(
                              text: 'Send Message',
                              onPressed: () {
                                // Get.toNamed(Routes.home);
                              },
                            ),
                          ],
                        ),
                      ),
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

  // Reusable Primary Button
  Widget _buildPrimaryButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: Get.width,
      height: Get.height / 20,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffF78520),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 5,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: Get.width / 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class FoodItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final VoidCallback onExploreMore;

  const FoodItemCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.onExploreMore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width, // Adjust width as needed
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
            child: Image.asset(
              imageUrl,
              height: Get.height / 4, // Adjust height as needed
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 13.0, color: Color(0xff666666)),
                ),
                SizedBox(height: Get.height / 50),
                ElevatedButton(
                  onPressed: onExploreMore,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFB8C00), // Orange color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 12.0,
                    ),
                  ),
                  child: const Text(
                    "Explore More",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
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

class FoodItemCard2 extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String weight;
  final String price;
  final String rating;
  final bool isPremium;
  final VoidCallback onAddToCart;

  const FoodItemCard2({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.weight,
    required this.price,
    this.rating = '4.2',
    this.isPremium = false,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 1.2, // responsive width
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          Get.width / 20,
        ), // responsive radius
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
                  height: Get.height / 4.5, // responsive height
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
                      "Premium",
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

                Text(
                  weight,
                  style: TextStyle(fontSize: 13.0, color: Color(0xff666666)),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹$price",
                      style: TextStyle(
                        fontSize: Get.width / 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: onAddToCart,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF78520),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Get.width / 30),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: Get.width / 15,
                          vertical: Get.height / 90,
                        ),
                      ),
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(
                          fontSize: Get.width / 28,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
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
    );
  }
}
