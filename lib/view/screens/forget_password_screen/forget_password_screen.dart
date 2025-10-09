import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/routes.dart';
import '../../component/textfield.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailOrPhoneController = TextEditingController();

  @override
  void dispose() {
    emailOrPhoneController.dispose();
    super.dispose();
  }

  void _sendCode() {
    // Validate the field
    bool isValid = FieldValidator.validateRequired({
      "Email or Phone Number": emailOrPhoneController,
    });

    if (!isValid) return;

    // Navigate to OTP screen if valid
    Get.toNamed(Routes.otpVerificationScreen);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
            color: const Color(0xffeaaf87),
            image: const DecorationImage(
              image: AssetImage(
                "asset/images/loginscreen/background_image.png",
              ),
              fit: BoxFit.cover,
              opacity: 0.2,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: Get.height / 20),

              // ===== Inner Container =====
              Expanded(
                child: Container(
                  width: Get.width / 1.1,
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width / 15,
                    vertical: Get.height / 32,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: Get.width / 20),
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(Get.width / 50),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              CupertinoIcons.back,
                              color: Colors.black,
                              size: Get.width / 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height / 15),

                      Text(
                        'Forget Password?',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: Get.width / 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF424242),
                          ),
                        ),
                      ),
                      Text(
                        'Continue your spiritual journey',
                        style: TextStyle(
                          fontSize: Get.width / 30,
                          color: Color(0xff4D5563),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: Get.height / 25),

                      Text(
                        'Email or Phone Number',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: Get.width / 22.5,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF424242),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height / 100),

                      CustomTextField(
                        hint: 'Enter your email or Phone Number',
                        controller: emailOrPhoneController,
                      ),

                      // ===== Push bottom content down =====
                      const Spacer(),

                      _buildPrimaryButton(
                        text: 'Send Code',
                        onPressed: _sendCode,
                      ),
                      SizedBox(height: Get.height / 50),

                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "By entering your number you agree to our",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Get.width / 36,
                              ),
                            ),
                            Text(
                              'Terms & Privacy policy',
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                                fontSize: Get.width / 36,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Get.height / 15),
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
