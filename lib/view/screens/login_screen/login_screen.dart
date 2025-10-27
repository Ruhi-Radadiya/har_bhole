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

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: Container(
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(
            color: Color(0xffeaaf87),
            image: DecorationImage(
              image: AssetImage(
                "asset/images/loginscreen/background_image.png",
              ),
              fit: BoxFit.cover,
              opacity: 0.2,
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                    left: Get.width / 25,
                    right: Get.width / 25,
                    bottom: 30,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
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
                                        color: const Color(0xFF424242),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Login to Sweet Moments & Savory Bites',
                                    style: TextStyle(
                                      fontSize: Get.width / 30,
                                      color: const Color(0xff4D5563),
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
                                    label: 'OTP',
                                    hint: 'Enter OTP',
                                    controller: otpController,
                                    keyboardType: TextInputType.number,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: Get.height / 45,
                                            width: Get.height / 45,
                                            child: Checkbox(
                                              value: true,
                                              onChanged: (bool? newValue) {},
                                              activeColor: const Color(
                                                0xffF78520,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: Get.width / 50),
                                          Text(
                                            'Remember me',
                                            style: TextStyle(
                                              color: const Color(0xff000000),
                                              fontSize: Get.width / 33,
                                            ),
                                          ),
                                        ],
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Get.toNamed(
                                            Routes.forgetPasswordScreen,
                                          );
                                        },
                                        child: Text(
                                          'Forgot password?',
                                          style: TextStyle(
                                            color: const Color(0xffF77457),
                                            fontWeight: FontWeight.w600,
                                            fontSize: Get.width / 33,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Get.height / 35),

                                  /// ✅ Login Button Logic
                                  _buildPrimaryButton(
                                    text: 'Login',
                                    onPressed: () {
                                      Get.toNamed(Routes.bottomNavigationBar);
                                    },
                                    // onPressed: () async {
                                    //   bool isValid =
                                    //       FieldValidator.validateRequired({
                                    //         "Mobile Number": emailController,
                                    //         "OTP": otpController,
                                    //       });
                                    //   if (!isValid) return;
                                    //
                                    //   final mobile = emailController.text
                                    //       .trim();
                                    //   final otp = otpController.text.trim();
                                    //   final savedMobile =
                                    //       loginController.signupMobile.value;
                                    //
                                    //   // 1️⃣ Match OTP
                                    //   if (otp != "123456") {
                                    //     Get.snackbar(
                                    //       "Invalid OTP",
                                    //       "Please enter correct OTP (Hint: 123456)",
                                    //       backgroundColor: Colors.redAccent,
                                    //       colorText: Colors.white,
                                    //       snackPosition: SnackPosition.BOTTOM,
                                    //     );
                                    //     return;
                                    //   }
                                    //
                                    //   // 2️⃣ Match mobile with signup mobile
                                    //   if (mobile != savedMobile) {
                                    //     Get.snackbar(
                                    //       "Invalid Mobile Number",
                                    //       "This number is not registered. Please sign up first.",
                                    //       backgroundColor: Colors.redAccent,
                                    //       colorText: Colors.white,
                                    //       snackPosition: SnackPosition.BOTTOM,
                                    //     );
                                    //     return;
                                    //   }
                                    //
                                    //   // 3️⃣ Optional: call your login API
                                    //   try {
                                    //     final response = await http.post(
                                    //       Uri.parse(
                                    //         "http://192.168.0.118/har_bhole_farsan/api/login_api.php",
                                    //       ),
                                    //       body: {"mobile": mobile},
                                    //     );
                                    //
                                    //     final data = jsonDecode(response.body);
                                    //     if (data["success"] == true) {
                                    //       Get.snackbar(
                                    //         "Login Successful",
                                    //         "Welcome back!",
                                    //         backgroundColor: Colors.green,
                                    //         colorText: Colors.white,
                                    //         snackPosition: SnackPosition.BOTTOM,
                                    //       );
                                    //       Get.toNamed(
                                    //         Routes.bottomNavigationBar,
                                    //       );
                                    //     } else {
                                    //       Get.snackbar(
                                    //         "Login Failed",
                                    //         data["message"] ??
                                    //             "Invalid mobile number",
                                    //         backgroundColor: Colors.redAccent,
                                    //         colorText: Colors.white,
                                    //         snackPosition: SnackPosition.BOTTOM,
                                    //       );
                                    //     }
                                    //   } catch (e) {
                                    //     Get.snackbar(
                                    //       "Error",
                                    //       "Something went wrong: $e",
                                    //       backgroundColor: Colors.redAccent,
                                    //       colorText: Colors.white,
                                    //       snackPosition: SnackPosition.BOTTOM,
                                    //     );
                                    //   }
                                    // },
                                  ),

                                  SizedBox(height: Get.height / 25),
                                  _buildDividerWithText('Or continue with'),
                                  SizedBox(height: Get.height / 25),
                                  _buildSocialButton(
                                    image:
                                        "asset/images/loginscreen/google.png",
                                    text: 'Continue with Google',
                                    iconColor: Colors.black,
                                  ),
                                  SizedBox(height: Get.height / 50),
                                  _buildSocialButton(
                                    image:
                                        "asset/images/loginscreen/facebook.png",
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
                                            color: const Color(0xffF77457),
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
                );
              },
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

  Widget _buildDividerWithText(String text) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.grey, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
          child: Text(
            text,
            style: TextStyle(
              color: const Color(0xff000000),
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
          side: const BorderSide(color: Colors.black, width: 0.8),
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
