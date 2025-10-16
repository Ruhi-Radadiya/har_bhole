import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/routes/routes.dart';

import '../../component/textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool _isPasswordHidden = true;
bool _isConfirmPasswordHidden = true;

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: Get.width / 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF424242),
                            ),
                          ),
                        ),
                        Text(
                          'Login to Sweet Moments & Savory Bites',
                          style: TextStyle(
                            fontSize: Get.width / 30,
                            color: Color(0xff4D5563),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: Get.height / 25),
                        CustomTextField(
                          label: 'Mobile number',
                          controller: emailController,
                          hint: 'Enter your mobile number',
                          image: "asset/icons/textfield_icon.png",
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: Get.height / 40),
                        CustomTextField(
                          label: 'Password',
                          hint: 'Enter your password',
                          image: "asset/icons/password_lock_icon.png",
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

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: Get.height / 45,
                                  width: Get.height / 45,
                                  child: Checkbox(
                                    value: true,
                                    onChanged: (bool? newValue) {
                                      setState(() {});
                                    },
                                    activeColor: Color(0xffF78520),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                ),
                                SizedBox(width: Get.width / 50),
                                Text(
                                  'Remember me',
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: Get.width / 33,
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.forgetPasswordScreen);
                              },
                              child: Text(
                                'Forgot password?',
                                style: TextStyle(
                                  color: Color(0xffF77457),
                                  fontWeight: FontWeight.w600,
                                  fontSize: Get.width / 33,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height / 35),
                        _buildPrimaryButton(
                          text: 'Login',
                          onPressed: () {
                            /// 🔹 Validate fields
                            bool isValid = FieldValidator.validateRequired({
                              "Email": emailController,
                              "Password": passwordController,
                            });

                            if (isValid) {
                              Get.toNamed(Routes.bottomNavigationBar);
                              print("Login success");
                            }
                          },
                        ),
                        SizedBox(height: Get.height / 25),
                        _buildDividerWithText('Or continue with'),
                        SizedBox(height: Get.height / 25),
                        _buildSocialButton(
                          image: "asset/images/loginscreen/google.png",
                          text: 'Continue with Google',
                          iconColor: Colors.black,
                        ),
                        SizedBox(height: Get.height / 50),
                        _buildSocialButton(
                          image: "asset/images/loginscreen/facebook.png",
                          text: 'Continue with Facebook',
                          iconColor: Colors.blue.shade800,
                        ),
                        SizedBox(height: Get.height / 50),
                        _buildSocialButton(
                          image: "asset/images/loginscreen/apple.png",
                          text: 'Continue with Apple',
                          iconColor: Colors.black,
                        ),
                        SizedBox(height: Get.height / 25),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Get.width / 30,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.createYourAccount);
                              },
                              child: Text(
                                'Sign up',
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
                ),
                SizedBox(height: Get.height / 15),
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

  Widget _buildDividerWithText(String text) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.grey, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
          child: Text(
            text,
            style: TextStyle(
              color: Color(0xff000000),
              fontSize: Get.width / 28,
            ),
          ),
        ),
        const Expanded(child: Divider(color: Colors.grey, thickness: 1)),
      ],
    );
  }

  Widget _buildSocialButton({
    required String image,
    required String text,
    required Color iconColor,
  }) {
    return SizedBox(
      width: Get.width,
      height: Get.height / 20,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          side: BorderSide(color: Colors.black, width: 0.8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.height / 35,
              width: Get.width / 20,
              child: Image(image: AssetImage(image)),
            ),
            SizedBox(width: Get.width / 30),
            Text(
              text,
              style: TextStyle(
                fontSize: Get.width / 28,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
