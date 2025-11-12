import 'dart:async';
import 'dart:io' show Platform;

// import 'package:uni_links/uni_links.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/controller/b2b_order/b2b_order_controller.dart';
import 'package:har_bhole/controller/cashbook_controller/create_cashbook_entery_controller.dart';
import 'package:har_bhole/controller/finished_goods_stock_controller/finished_goods_stock_controller.dart';
import 'package:har_bhole/controller/location_controller.dart';
import 'package:har_bhole/controller/order_analytics_controller/order_analytics_controller.dart';
import 'package:har_bhole/controller/product_controller/delete_product_controller.dart';
import 'package:har_bhole/controller/product_controller/product_controller.dart';
import 'package:har_bhole/controller/raw_material_controller/raw_material_controller.dart';
import 'package:har_bhole/controller/semi_finished_material_controller/semi_finished_material_controller.dart';
import 'package:har_bhole/controller/users_controller/create_user_controller.dart';
import 'package:har_bhole/controller/voucher_controller/add_voucher_controller.dart';
import 'package:har_bhole/routes/routes.dart';

import 'controller/all_orders_controller/all_orders_controller.dart';
import 'controller/b2b_order/create_b2b_order_controller.dart';
import 'controller/b2b_user_controller/b2b_user_controller.dart';
import 'controller/b2b_user_controller/create_b2b_user_controller.dart';
import 'controller/banner_controller/banner_controller.dart';
import 'controller/cart_controller/order_controller.dart';
import 'controller/cashbook_controller/cashbook_controller.dart';
import 'controller/category_controller/category_controller.dart';
import 'controller/category_controller/create_new_category_controller.dart';
import 'controller/category_controller/delete_category_controller.dart';
import 'controller/customer_detail_controller/customer_detail_controller.dart';
import 'controller/login_controller.dart';
import 'controller/navigation_controller/navigation.dart';
import 'controller/navigation_controller/user_dashboard_navigation_controller.dart';
import 'controller/orders_controller/orders_controller.dart';
import 'controller/product_controller/add_product_controller.dart';
import 'controller/registration_controller.dart';
import 'controller/stock_movement_controller/stock_movement_controller.dart';
import 'controller/supplier_controller/add_supplier_controller.dart';
import 'controller/supplier_controller/supplier_controller.dart';
import 'controller/users_controller/dashboard_users_controller.dart';
import 'controller/voucher_controller/voucher_controller.dart';

CreateUserController createUserController = Get.put(CreateUserController());
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
OrdersController ordersController = Get.put(OrdersController());
CustomerDetailController customerDetailController = Get.put(
  CustomerDetailController(),
);
RawMaterialController rawMaterialController = Get.put(RawMaterialController());
SemiFinishedController semiFinishedController = Get.put(
  SemiFinishedController(),
);
CashbookController cashbookController = Get.put(
  CashbookController(),
  permanent: true,
);
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

AddSupplierController addSupplierController = Get.put(AddSupplierController());
DeleteProductController deleteProductController = Get.put(
  DeleteProductController(),
);
DeleteCategoryController deleteCategoryController = Get.put(
  DeleteCategoryController(),
);

BannerController bannerController = Get.put(BannerController());
LoginController loginController = Get.put(LoginController());
StockMovementController stockMovementController = Get.put(
  StockMovementController(),
);
OrderAnalyticsController orderAnalyticsController = Get.put(
  OrderAnalyticsController(),
);
AllOrdersController allOrdersController = Get.put(AllOrdersController());
UserDashboardController userDashboardController = Get.put(
  UserDashboardController(),
);
LocationController locationController = Get.put(LocationController());
NavigationController navigationController = Get.put(NavigationController());
RegistrationController registrationController = Get.put(
  RegistrationController(),
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
    return DeepLinkInitializer(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.introScreen,
        getPages: Routes.myRoutes,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        ),
      ),
    );
  }
}

class DeepLinkInitializer extends StatefulWidget {
  final Widget child;
  const DeepLinkInitializer({super.key, required this.child});

  @override
  State<DeepLinkInitializer> createState() => _DeepLinkInitializerState();
}

class _DeepLinkInitializerState extends State<DeepLinkInitializer> {
  AppLinks? _appLinks;
  @override
  void initState() {
    super.initState();
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      _initAppLinks();
    }
  }

  Future<void> _initAppLinks() async {
    try {
      _appLinks = AppLinks();
      final initialLink = await _appLinks!.getInitialLink();
      if (initialLink != null) {
        _handleUri(initialLink);
      }
      _appLinks!.uriLinkStream.listen((uri) {
        _handleUri(uri);
      }, onError: (_) {});
    } catch (_) {
      // ignore
    }
  }

  void _handleUri(Uri uri) async {
    // Expect: https://harbhole.eihlims.com/product?id=123
    final host = uri.host.toLowerCase();
    final path = uri.path.toLowerCase();
    if ((host.contains('harbhole.eihlims.com') || host.contains('harbhole')) &&
        path.contains('product')) {
      final productId = uri.queryParameters['id'];
      if (productId != null && productId.isNotEmpty) {
        // Ensure products loaded
        if (productController.productList.isEmpty) {
          await productController.fetchProducts();
        }
        final product = productController.productList.firstWhereOrNull(
          (p) => p.productId.toString() == productId,
        );
        if (product != null) {
          Get.toNamed(Routes.productDetails, arguments: product);
        } else {
          // fallback: go to products list
          Get.toNamed(Routes.products);
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
