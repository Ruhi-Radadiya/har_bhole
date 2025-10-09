import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/routes.dart';
import '../../component/textfield.dart';

class CreateYourAccount extends StatefulWidget {
  const CreateYourAccount({super.key});

  @override
  State<CreateYourAccount> createState() => _CreateYourAccountState();
}

class _CreateYourAccountState extends State<CreateYourAccount> {
  // Controllers
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Password visibility toggles
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _onCreateAccount() {
    // Validate required fields
    bool isValid = FieldValidator.validateRequired({
      "Username": usernameController,
      "Email": emailController,
      "Mobile No": mobileController,
      "Password": passwordController,
      "Confirm Password": confirmPasswordController,
    });

    if (!isValid) return;

    // Check if passwords match
    if (passwordController.text.trim() !=
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

    // If everything is valid, show success message
    Get.snackbar(
      "Success",
      "Account Created Successfully!",
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(12),
    );

    // Navigate to admin_dashboard or next screen
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
            image: DecorationImage(
              image: AssetImage(
                "asset/images/loginscreen/background_image.png",
              ),
              fit: BoxFit.cover,
              opacity: 0.2,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Get.height / 20),
                Image.asset(
                  "asset/images/loginscreen/om_har_bhole_logo.png",
                  height: Get.height / 14,
                  errorBuilder: (context, error, stackTrace) => Text(
                    'OM Har Bhole Logo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.width / 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: Get.height / 28),
                Container(
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
                      Text(
                        'Create your account',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: Get.width / 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF424242),
                          ),
                        ),
                      ),
                      Text(
                        'Create your Sweet Moments & Savory Bites',
                        style: TextStyle(
                          fontSize: Get.width / 30,
                          color: Color(0xff4D5563),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: Get.height / 35),

                      /// Username
                      Text(
                        "Username",
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
                        hint: 'Enter your name',
                        image: "asset/images/loginscreen/user_icon.png",
                        keyboardType: TextInputType.name,
                        controller: usernameController,
                      ),
                      SizedBox(height: Get.height / 60),

                      /// Email
                      Text(
                        "Email",
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
                        hint: 'Enter your Email',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                      ),
                      SizedBox(height: Get.height / 60),

                      /// Mobile
                      Text(
                        "Mobile No",
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
                        hint: 'Enter your Mobile Number',
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        controller: mobileController,
                      ),
                      SizedBox(height: Get.height / 60),

                      /// Password
                      Text(
                        "Password",
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
                        hint: 'Enter your password',
                        image: "asset/images/loginscreen/lock_icon.png",
                        isPassword: _isPasswordHidden,
                        controller: passwordController,
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

                      /// Confirm Password
                      Text(
                        "Confirm Password",
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
                        hint: 'Enter your Confirm Password',
                        image: "asset/images/loginscreen/lock_icon.png",
                        isPassword: _isConfirmPasswordHidden,
                        controller: confirmPasswordController,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordHidden
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordHidden =
                                  !_isConfirmPasswordHidden;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: Get.height / 80),

                      /// Remember Me
                      Row(
                        children: [
                          Checkbox(
                            value: true,
                            onChanged: (val) {},
                            activeColor: const Color(0xffF78520),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          Text(
                            'Remember me',
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: Get.width / 33,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height / 100),

                      _buildPrimaryButton(
                        text: 'Create Account',
                        onPressed: _onCreateAccount,
                      ),

                      SizedBox(height: Get.height / 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Get.width / 30,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed(Routes.loginScreen),
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                color: Color(0xffF77457),
                                fontWeight: FontWeight.w600,
                                fontSize: Get.width / 30,
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
          backgroundColor: Color(0xffF78520),
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
