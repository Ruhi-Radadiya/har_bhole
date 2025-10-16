import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/routes.dart';

class B2B extends StatefulWidget {
  const B2B({super.key});

  @override
  State<B2B> createState() => _B2BState();
}

class _B2BState extends State<B2B> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F9FA),
      body: Stack(
        children: [
          Container(
            height: Get.height * 0.33,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFE0CC),
                  Color(0xFFF7C79C),
                  Color(0xFFF7F7F7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.6, 1.0],
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: Get.width / 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height / 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          // Admin Icon
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 5,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: SizedBox(
                              height: Get.width / 18,
                              width: Get.width / 18,
                              child: Image(
                                image: AssetImage(
                                  'asset/icons/profile_icon.png',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: Get.width / 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Admin',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: Get.width / 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Text(
                                'Farsan Business Hub',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: Get.width / 26,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 5,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: SizedBox(
                              height: Get.width / 18,
                              width: Get.width / 18,
                              child: Image(
                                image: AssetImage('asset/icons/bell_icon.png'),
                              ),
                            ),
                          ),
                          SizedBox(width: Get.width / 30),
                          CircleAvatar(
                            radius: Get.width / 18,
                            backgroundImage: const AssetImage(
                              'asset/images/person_image.jpg',
                            ),
                            backgroundColor: Colors.grey.shade200,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height / 40),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(Get.width / 20),
                    decoration: BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back, Admin!',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: Get.width / 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height / 120),
                        Text(
                          'Manage your farsan business with ease',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: Get.width / 30,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height / 30),
                  _buildMenuItemTile(
                    image: "asset/icons/users_icon.png",
                    title: 'B2B Users',
                    iconColor: Color(0xffF78520),
                    onTap: () {
                      Get.toNamed(Routes.b2bUser);
                    },
                  ),
                  _buildMenuItemTile(
                    image: "asset/icons/b2b_order.png",
                    title: 'B2B Orders',
                    iconColor: Color(0xffF78520),
                    onTap: () {
                      Get.toNamed(Routes.b2bOrder);
                    },
                  ),
                  SizedBox(height: Get.height / 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItemTile({
    required String image,
    required String title,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.0),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18.0),
          child: Container(
            height: Get.height / 11,
            padding: EdgeInsets.symmetric(horizontal: Get.width / 16),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18.0),
              border: Border.all(color: Colors.grey.shade200, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1), // shadow color
                  blurRadius: 8, // softness of shadow
                  offset: const Offset(0, 4), // x, y offset
                ),
              ],
            ),
            child: Row(
              children: [
                SizedBox(
                  height: Get.width / 16,
                  width: Get.width / 16,
                  child: Image.asset(image, color: iconColor),
                ),
                SizedBox(width: Get.width / 25),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: Get.width / 22.5,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff4B4B4B),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
