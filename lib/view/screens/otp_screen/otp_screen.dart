import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../routes/routes.dart';
import '../../component/textfield.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  void _verifyOtp() {
    // Validate OTP field
    bool isValid = FieldValidator.validateRequired({"OTP": otpController});

    if (!isValid) return;

    // Navigate if valid
    Get.toNamed(Routes.setNewPassword);
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
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        'Enter OTP to verify',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF424242),
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Text(
                        'A one-time password(OTP) has been sent\nto your registered email or phone number',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff4D5563),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: Get.height / 25),

                      // ===== OTP Boxes =====
                      PinCodeTextField(
                        appContext: context,
                        controller: otpController,
                        length: 6,
                        onChanged: (value) {},
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(10),
                          fieldHeight: Get.width / 7.5,
                          fieldWidth: Get.width / 9,
                          activeFillColor: Colors.white,
                          inactiveFillColor: Colors.white,
                          selectedFillColor: Colors.white,
                          activeColor: Colors.transparent,
                          inactiveColor: Colors.transparent,
                          selectedColor: Colors.transparent,
                          inactiveBorderWidth: 0.5,
                          activeBorderWidth: 1,
                        ),
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        enableActiveFill: true,
                      ),
                      SizedBox(height: Get.height / 50),

                      // Resend option
                      Row(
                        children: [
                          Text(
                            "Didn't get a code?",
                            style: TextStyle(
                              fontSize: 10.5,
                              color: Color(0xff000000),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // TODO: Add resend OTP functionality
                            },
                            child: const Text(
                              " Resend it",
                              style: TextStyle(
                                fontSize: 10.5,
                                color: Color(0xffF77457),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      // Continue Button
                      SizedBox(
                        width: Get.width,
                        height: Get.height / 20,
                        child: ElevatedButton(
                          onPressed: _verifyOtp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffF78520),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 5,
                          ),
                          child: Text(
                            "Continue",
                            style: TextStyle(
                              fontSize: Get.width / 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height / 50),

                      const Text(
                        "By entering your number you agree to our",
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ),
                      const Text(
                        'Terms & Privacy policy',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          decoration: TextDecoration.underline,
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
}
