import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/routes.dart';
import '../../component/textfield.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _ContactState extends State<Contact> {
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
                    Container(
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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 25.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.05),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Contact Information',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 18.5,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height / 160),
                              const Text(
                                'Read us through any these channels',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xff4A4745),
                                ),
                              ),
                              SizedBox(height: Get.height / 30),
                              _buildContactItem(
                                icon: Icons.location_on,
                                iconColor: Color(0xffF7611B),
                                title: 'Address',
                                subtitle:
                                    'Har Bhole Complex, Sayaji Library Rd, Navsari, Gujarat 396445',
                              ),
                              _buildContactItem(
                                icon: Icons.phone,
                                iconColor: Color(0xffFAA423),
                                title: 'Phone',
                                subtitle: '+91 6359444040',
                              ),
                              _buildContactItem(
                                icon: Icons.email,
                                iconColor: Color(0xffF7611B),
                                title: 'Email',
                                subtitle: 'info@omharbhole.com',
                              ),
                            ],
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
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          tileColor: Color(0xffFAF7F6),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 0.0,
          ),
          leading: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
            child: Icon(icon, size: 28, color: Colors.white),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(fontSize: 11, color: Color(0xff4A4745)),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: const SizedBox(width: 0),
        ),
      ),
    );
  }

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
