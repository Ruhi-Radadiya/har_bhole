import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/routes.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xffF78520),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 🔶 Top container where you'll add your own image
            Container(
              width: Get.width,
              height: Get.height * 0.55,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                child: Image.asset(
                  "asset/images/intro.png",
                  fit: BoxFit.cover, // Ensures image fills the container nicely
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            // 🟠 Orange Section
            Expanded(
              child: Container(
                width: Get.width,
                color: const Color(0xffF78520),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ⚪ Page Indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: index == currentIndex ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: index == currentIndex
                                ? Colors.white
                                : Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height / 18),
                    Text(
                      "Welcome to Om Har Bhole",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: Get.width / 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height / 90),
                    Text(
                      textAlign: TextAlign.center,
                      "Snack smart, snack tasty — your favorite farsan,\nnow just a tap away!",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: Get.width / 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height / 20),
                    // 👤 Guest Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                      ),
                      onPressed: () {
                        Get.toNamed(Routes.splashScreen);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 60,
                          vertical: 15,
                        ),
                        child: Text(
                          "GUEST",
                          style: TextStyle(
                            color: Color(0xffF78520),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height / 60),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                      ),
                      onPressed: () {
                        Get.toNamed(Routes.loginScreen);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 60,
                          vertical: 15,
                        ),
                        child: Text(
                          "LOG IN",
                          style: TextStyle(
                            color: Color(0xffF78520),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height / 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
