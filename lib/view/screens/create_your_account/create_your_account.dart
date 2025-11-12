import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../main.dart';
import '../../../routes/routes.dart';
import '../../component/textfield.dart';

class CreateYourAccount extends StatefulWidget {
  const CreateYourAccount({super.key});

  @override
  State<CreateYourAccount> createState() => _CreateYourAccountState();
}

class _CreateYourAccountState extends State<CreateYourAccount> {
  @override
  void dispose() {
    // Don't dispose controllers here as they are managed by GetX
    super.dispose();
  }

  void _onCreateAccount() {
    registrationController.registerUser();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: Get.width / 25,
                right: Get.width / 25,
                bottom: Get.height / 50,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: Get.height / 25),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create your account',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: Get.width / 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF424242),
                            ),
                          ),
                        ),
                        Text(
                          'Create your Sweet Moments & Savory Bites',
                          style: TextStyle(
                            fontSize: Get.width / 30,
                            color: const Color(0xff4D5563),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: Get.height / 35),

                        CustomTextField(
                          label: 'Username',
                          hint: 'Enter your name',
                          image: "asset/images/loginscreen/user_icon.png",
                          keyboardType: TextInputType.name,
                          controller: registrationController.usernameController,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Email',
                          hint: 'Enter your Email',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          controller: registrationController.emailController,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Address',
                          hint: 'Enter your Address',
                          icon: Icons.location_on,
                          controller: registrationController.addressController,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Mobile Number',
                          hint: 'Enter your Mobile Number',
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                          controller: registrationController.mobileController,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'City',
                          hint: 'Enter your City',
                          icon: Icons.location_city,
                          controller: registrationController.cityController,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'PIN Code',
                          hint: 'Enter your PIN Code',
                          icon: Icons.pin,
                          keyboardType: TextInputType.number,
                          controller: registrationController.pincodeController,
                        ),
                        SizedBox(height: Get.height / 60),

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
                                color: const Color(0xff000000),
                                fontSize: Get.width / 33,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: Get.height / 100),
                        Obx(
                          () => _buildPrimaryButton(
                            text: 'Create Account',
                            onPressed: registrationController.isLoading.value
                                ? null
                                : _onCreateAccount,
                            isLoading: registrationController.isLoading.value,
                          ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrimaryButton({
    required String text,
    required VoidCallback? onPressed,
    required bool isLoading,
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
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
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
