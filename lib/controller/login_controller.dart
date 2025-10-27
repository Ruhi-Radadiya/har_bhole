import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  // Store user info (you can expand this later)
  var signupMobile = ''.obs;

  void setSignupMobile(String mobile) {
    signupMobile.value = mobile;
  }
}
