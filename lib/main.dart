import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/controller/b2b_order/b2b_order_controller.dart';
import 'package:har_bhole/controller/product_controller/product_controller.dart';
import 'package:har_bhole/controller/user_controller/create_user_controller.dart';
import 'package:har_bhole/controller/user_controller/user_controller.dart';
import 'package:har_bhole/routes/routes.dart';

import 'controller/b2b_user_controller/b2b_user_controller.dart';
import 'controller/cart_controller/order_controller.dart';
import 'controller/home_page_controllers/premium_collection_controller.dart';
import 'controller/users_controller/dashboard_users_controller.dart';

CreateUserController createUserController = Get.put(CreateUserController());
UserController userController = Get.put(UserController());
OrderCartController orderCartController = Get.put(OrderCartController());
PremiumCollectionController premiumCollectionController = Get.put(
  PremiumCollectionController(),
);
ProductController productController = Get.put(ProductController());
B2BUserController b2bUserController = Get.put(B2BUserController());
B2BOrderController b2bOrderController = Get.put(B2BOrderController());
DashboardUsersController dashboardUsersController = Get.put(
  DashboardUsersController(),
);

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
