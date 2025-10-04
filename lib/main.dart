import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/controller/user_controller/create_user_controller.dart';
import 'package:har_bhole/controller/user_controller/user_controller.dart';
import 'package:har_bhole/routes/routes.dart';

import 'controller/product_controller/product_controller.dart';

CreateUserController createUserController = Get.put(CreateUserController());
UserController userController = Get.put(UserController());
ProductController productController = Get.put(ProductController());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.loginScreen,
      getPages: Routes.myRoutes,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
    );
  }
}
