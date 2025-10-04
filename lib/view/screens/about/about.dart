import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/routes.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xffF7F9FA),
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25,
                                    vertical: 12,
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
                padding: const EdgeInsets.only(
                  // top: 10.0,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Our Legacy, your Flavor",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Color(0xff828590),
                              fontSize: 16.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height / 50),
                  ],
                ),
              ),
              foodCard(
                imageUrl: "asset/images/about/jalebi.png",
                title: "Authentic Flavorss",
                description:
                    "Experience the true taste of tradition with our hand-crafted namkeen, made using age-old recipes and the finest ingredients. Every bite brings you closer to the roots of Indian snacking culture.",
              ),
              foodCard(
                imageUrl: "asset/images/about/jalebi.png",
                title: "Authentic Flavorss",
                description:
                    "Experience the true taste of tradition with our hand-crafted namkeen, made using age-old recipes and the finest ingredients. Every bite brings you closer to the roots of Indian snacking culture.",
              ),
              foodCard(
                imageUrl: "asset/images/about/jalebi.png",
                title: "Authentic Flavorss",
                description:
                    "Experience the true taste of tradition with our hand-crafted namkeen, made using age-old recipes and the finest ingredients. Every bite brings you closer to the roots of Indian snacking culture.",
              ),
              foodCard(
                imageUrl: "asset/images/about/jalebi.png",
                title: "Authentic Flavorss",
                description:
                    "Experience the true taste of tradition with our hand-crafted namkeen, made using age-old recipes and the finest ingredients. Every bite brings you closer to the roots of Indian snacking culture.",
              ),
              Center(
                child: Container(
                  height: Get.height / 2.5,
                  width: Get.width,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: Get.width / 20,
                        offset: Offset(0, Get.height / 80),
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: Get.width / 15,
                        offset: Offset(0, Get.height / 50),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: Get.width / 8,
                            height: Get.width / 8,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Color(0xffED5439), Color(0xffDB2730)],
                              ),
                              borderRadius: BorderRadius.circular(
                                Get.width / 25,
                              ),
                            ),
                            child: Icon(
                              Icons.favorite,
                              color: Colors.white,
                              size: Get.width / 14,
                            ),
                          ),
                          SizedBox(width: Get.width / 25),
                          Expanded(
                            child: Text(
                              "Our Story",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height / 100),
                      Text(
                        "Welcome to Om Har Bhole Farsan, a family-owned business with over 50 years of experience in crafting authentic traditional farsan and namkeen. Our journey began in 2009-2010 with a simple mission ssss- to deliver the best taste in Navsari... From the beginning, we faced many challenges and competition, but our dedication to quality and customer satisfaction has helped us grow from a small family kitchen to serving over 1,000,000+ happy customers.aaaaaaaa Our specialties include patties, mix farsan, and corn flakes. We maintain the highest standards of cleanliness and hygiene, ensuring every product meets our customer.",
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.4,
                          color: Colors.grey[800],
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Get.height / 30),
              Container(
                width: double.infinity,
                // Add a light gradient/background color to mimic the image's background
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.withOpacity(0.05),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  // The background is a very light gradient from top to bottom
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xffFFF1ED),
                      Color(0xffFCECEB),
                      Color(0xffFAE6E8),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(25.0),
                margin: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize
                      .min, // Ensures container height wraps content
                  children: [
                    // Title
                    const Text(
                      'Why Choose Us?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: Get.height / 40),
                    // List of reasons
                    _buildChecklistItem(
                      title: '10+ Products',
                      subtitle:
                          'Extensive range of products including patties, mix farsan, corn flakes, and more.',
                    ),
                    _buildChecklistItem(
                      title: '1M+ Happy Customers',
                      subtitle:
                          'Serving over a million satisfied customers with our quality products.',
                    ),
                    _buildChecklistItem(
                      title: 'Clean & Hygiene',
                      subtitle:
                          'We maintain the highest standards of cleanliness and hygiene in all our processes.',
                    ),
                    _buildChecklistItem(
                      title: 'Made with Love',
                      subtitle:
                          'Traditional family recipes prepared with care and dedication since 2009.',
                    ),
                    _buildChecklistItem(
                      title: 'Best in Navsari',
                      subtitle:
                          'Recognized as the best farsan provider in Navsari with authentic taste.',
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.withOpacity(0.05),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xffFFF1ED),
                      Color(0xffFCECEB),
                      Color(0xffFAE6E8),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(25.0),
                margin: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize
                      .min, // Ensures container height wraps content
                  children: [
                    // Title
                    const Text(
                      'Our Values',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: Get.height / 40),
                    // List of reasons
                    _buildChecklistItem(
                      title: 'Best Taste in Navsari',
                      subtitle:
                          'From 2010, we started to progress with new and different upcoming ideas to deliver the best taste.',
                    ),
                    _buildChecklistItem(
                      title: 'Customer Choice',
                      subtitle:
                          'We have always taken special care of the choices of our esteemed customers.',
                    ),
                    _buildChecklistItem(
                      title: 'Clean & Hygiene',
                      subtitle:
                          'We keep everything clean and maintain the highest hygiene standards in our facility.',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  bottom: 20,
                  right: 20,
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Ready to Ship Best Farsan in Navsari?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: Get.height / 150),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Discover our premium collection of traditional farsan and namkeen varieties',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xff4A4745),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height / 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              print('Shop Now tapped');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffF78520),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 5,
                              ),
                              minimumSize: const Size(100, 40),
                            ),
                            child: const Text(
                              'Shop Now',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: Get.width / 25),
                          OutlinedButton(
                            onPressed: () {
                              print('Contact Us tapped');
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.grey.shade200,
                              foregroundColor: Colors.black87,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              side: BorderSide.none,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 5,
                              ),
                              minimumSize: const Size(100, 40),
                            ),
                            child: const Text(
                              'Contact Us',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget foodCard({
    required String imageUrl,
    required String title,
    required String description,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          left: Get.width / 20,
          right: Get.width / 20,
          bottom: Get.height / 50,
        ),
        child: Container(
          width: double.infinity,
          height: Get.height / 6.2,
          padding: EdgeInsets.all(Get.width / 25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Get.width / 20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: Get.width / 100,
                blurRadius: Get.width / 50,
                offset: Offset(0, Get.height / 200),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              ClipRRect(
                borderRadius: BorderRadius.circular(Get.width / 25),
                child: Image.asset(
                  imageUrl,
                  width: Get.width / 3,
                  height: Get.height / 8,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: Get.width / 40),
              // Text Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      maxLines: 1,

                      style: TextStyle(
                        fontSize: 16,

                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(fontSize: 10.5, color: Colors.grey[700]),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
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

  Widget _buildChecklistItem({
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Checkmark Icon
          Container(
            margin: const EdgeInsets.only(top: 3.0, right: 10.0),
            child: const Icon(
              Icons.check_circle, // Standard checkmark icon
              color: Color(0xffF7663E),
              size: 18,
            ),
          ),
          // Text Content (Title and Subtitle)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: Get.height / 200),

                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[700],
                    height: 1.3,
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
