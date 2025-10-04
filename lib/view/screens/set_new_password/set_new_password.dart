import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/routes.dart';
import '../../component/textfield.dart';

class SetNewPassword extends StatefulWidget {
  const SetNewPassword({super.key});

  @override
  State<SetNewPassword> createState() => _SetNewPasswordState();
}

bool _isPasswordHidden = true;
bool _isPasswordHidden2 = true;

class _SetNewPasswordState extends State<SetNewPassword> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _onContinue() {
    bool isValid = FieldValidator.validateRequired({
      "New Password": newPasswordController,
      "Confirm Password": confirmPasswordController,
    });

    if (!isValid) return;

    if (newPasswordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      Get.snackbar(
        "Error",
        "Passwords do not match",
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(12),
      );
      return;
    }

    // Navigate if everything is valid
    Get.toNamed(Routes.bottomNavigationBar);
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
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
                        'Set New Password',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF424242),
                          ),
                        ),
                      ),
                      const Text(
                        'The password must be different than before',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff4D5563),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: Get.height / 25),

                      Text(
                        'Create your new password',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF424242),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height / 100),
                      CustomTextField(
                        hint: 'New password',
                        image: "asset/images/loginscreen/lock_icon.png",
                        isPassword: _isPasswordHidden,
                        controller: newPasswordController,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordHidden
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordHidden = !_isPasswordHidden;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: Get.height / 60),

                      Text(
                        'Confirm your new password',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF424242),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height / 100),
                      CustomTextField(
                        hint: 'Confirm password',
                        image: "asset/images/loginscreen/lock_icon.png",
                        isPassword: _isPasswordHidden2,
                        controller:
                            confirmPasswordController, // ✅ use correct controller
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordHidden2
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordHidden2 = !_isPasswordHidden2;
                            });
                          },
                        ),
                      ),

                      const Spacer(),

                      _buildPrimaryButton(
                        text: 'Continue',
                        onPressed: _onContinue,
                      ),
                      SizedBox(height: Get.height / 50),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              "By entering your number you agree to our",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              'Terms & Privacy policy',
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                                fontSize: 10,
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
