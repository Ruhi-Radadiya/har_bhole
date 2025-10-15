import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/controller/b2b_order/b2b_order_controller.dart';
import 'package:har_bhole/controller/cashbook_controller/create_cashbook_entery_controller.dart';
import 'package:har_bhole/controller/finished_goods_stock_controller/finished_goods_stock_controller.dart';
import 'package:har_bhole/controller/product_controller/product_controller.dart';
import 'package:har_bhole/controller/raw_material_controller/raw_material_controller.dart';
import 'package:har_bhole/controller/semi_finished_material_controller/semi_finished_material_controller.dart';
import 'package:har_bhole/controller/user_controller/create_user_controller.dart';
import 'package:har_bhole/controller/user_controller/user_controller.dart';
import 'package:har_bhole/controller/voucher_controller/add_voucher_controller.dart';
import 'package:har_bhole/routes/routes.dart';

import 'controller/b2b_order/create_b2b_order_controller.dart';
import 'controller/b2b_user_controller/b2b_user_controller.dart';
import 'controller/b2b_user_controller/create_b2b_user_controller.dart';
import 'controller/cart_controller/order_controller.dart';
import 'controller/cashbook_controller/cashbook_controller.dart';
import 'controller/customer_detail_controller/customer_detail_controller.dart';
import 'controller/finished_goods_stock_controller/add_finished_goods_stock_controller.dart';
import 'controller/home_page_controllers/create_new_category_controller.dart';
import 'controller/home_page_controllers/premium_collection_controller.dart';
import 'controller/orders_controller/orders_controller.dart';
import 'controller/product_controller/add_product_controller.dart';
import 'controller/raw_material_controller/add_raw_material_controller.dart';
import 'controller/supplier_controller/add_supplier_controller.dart';
import 'controller/supplier_controller/supplier_controller.dart';
import 'controller/users_controller/dashboard_users_controller.dart';
import 'controller/voucher_controller/voucher_controller.dart';

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
VouchersController vouchersController = Get.put(VouchersController());
AllOrdersController allOrdersController = Get.put(AllOrdersController());
CustomerDetailController customerDetailController = Get.put(
  CustomerDetailController(),
);
RawMaterialController rawMaterialController = Get.put(RawMaterialController());
SemiFinishedController semiFinishedController = Get.put(
  SemiFinishedController(),
);
CashbookController cashbookController = Get.put(CashbookController());
FinishedGoodsStockController finishedGoodsStockController = Get.put(
  FinishedGoodsStockController(),
);
SupplierController supplierController = Get.put(SupplierController());
CreateCategoryController createCategoryController = Get.put(
  CreateCategoryController(),
);
CreateProductController createProductController = Get.put(
  CreateProductController(),
);
CreateB2bUserController createB2bUserController = Get.put(
  CreateB2bUserController(),
);
CreateB2BOrderController createB2BOrderController = Get.put(
  CreateB2BOrderController(),
);
CashEntryController cashEntryController = Get.put(CashEntryController());
AddVoucherController addVoucherController = Get.put(AddVoucherController());
AddRawMaterialController addRawMaterialController = Get.put(
  AddRawMaterialController(),
);
AddFinishedGoodsStockController addFinishedGoodsStockController = Get.put(
  AddFinishedGoodsStockController(),
);
AddSupplierController addSupplierController = Get.put(AddSupplierController());

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
