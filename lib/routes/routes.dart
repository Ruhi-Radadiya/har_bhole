import 'package:get/get.dart';
import 'package:har_bhole/view/screens/shopping/shopping_card.dart';

import '../model/b2b_order/b2b_order_model.dart';
import '../view/screens/admin_bottom_bar.dart';
import '../view/screens/admin_dashboard/cashbook/cashbook_screen.dart';
import '../view/screens/admin_dashboard/cashbook/creat_cashbook_entry.dart';
import '../view/screens/admin_dashboard/cashbook/view_net_banking.dart';
import '../view/screens/admin_dashboard/categories/categories_screen.dart';
import '../view/screens/admin_dashboard/categories/categoris_detail_screen.dart';
import '../view/screens/admin_dashboard/categories/create_new_category_screen.dart';
import '../view/screens/admin_dashboard/products/create_new_product_screen.dart';
import '../view/screens/admin_dashboard/products/product_detail_screen.dart';
import '../view/screens/admin_dashboard/products/products_screen.dart';
import '../view/screens/admin_dashboard/user_dashboard_screen/add_user_screen.dart';
import '../view/screens/admin_dashboard/user_dashboard_screen/user_dashboard_screen.dart';
import '../view/screens/admin_dashboard/user_dashboard_screen/view_details_screen.dart';
import '../view/screens/admin_dashboard/voucher/add_voucher.dart';
import '../view/screens/admin_dashboard/voucher/general_voucher_screen.dart';
import '../view/screens/admin_dashboard/voucher/view_voucher.dart';
import '../view/screens/b2b/b2b_order/b2b_order_screen.dart';
import '../view/screens/b2b/b2b_order/create_new_b2b_order.dart';
import '../view/screens/b2b/b2b_order/invoice_screen.dart';
import '../view/screens/b2b/b2b_order/order_detail_screen.dart';
import '../view/screens/b2b/b2b_users/b2b_user_screen.dart';
import '../view/screens/b2b/b2b_users/create_new_b2b_user.dart';
import '../view/screens/bottom_navigation_bar.dart';
import '../view/screens/create_your_account/create_your_account.dart';
import '../view/screens/forget_password_screen/forget_password_screen.dart';
import '../view/screens/frenchies/frenchies.dart';
import '../view/screens/home/home.dart';
import '../view/screens/login_screen/login_screen.dart';
import '../view/screens/order/customer_details/customer_detail_screen.dart';
import '../view/screens/order/customer_details/view_customer_detail_screen.dart';
import '../view/screens/order/customer_orders/customer_order.dart';
import '../view/screens/order/customer_orders/customer_order_invoice.dart';
import '../view/screens/order/customer_orders/view_customer_order.dart';
import '../view/screens/order/orders/all_orders.dart';
import '../view/screens/order/orders/all_orders_detail_screen.dart';
import '../view/screens/order/orders_analytics/order_analytics.dart';
import '../view/screens/order/orders_analytics/order_analytics_invoice.dart';
import '../view/screens/order/orders_analytics/view_order_analytics.dart';
import '../view/screens/otp_screen/otp_screen.dart';
import '../view/screens/products/products.dart';
import '../view/screens/set_new_password/set_new_password.dart';
import '../view/screens/shopping/checkout.dart';
import '../view/screens/stock/finished_product/create_new_finished_product_screen.dart';
import '../view/screens/stock/finished_product/finished_goods_screen.dart';
import '../view/screens/stock/finished_product/view_new_finished_product_screen.dart';
import '../view/screens/stock/raw_material/add_new_raw_material.dart';
import '../view/screens/stock/raw_material/raw_material_screen.dart';
import '../view/screens/stock/raw_material/view_all_material.dart';
import '../view/screens/stock/semi_finished/create_new_semi_finished.dart';
import '../view/screens/stock/semi_finished/semi_finished_material.dart';
import '../view/screens/stock/semi_finished/view_all_semi_finished_material.dart';
import '../view/screens/stock/stock_movement/add_stock_movement_screen.dart';
import '../view/screens/stock/stock_movement/stock_movement_screen.dart';
import '../view/screens/stock/stock_movement/view_stock_movement_screen.dart';
import '../view/screens/stock/supplier/add_new_supplier.dart';
import '../view/screens/stock/supplier/supplier_screen.dart';
import '../view/screens/stock/supplier/view_supplier_screen.dart';

class Routes {
  static String loginScreen = '/login-screen';
  static String createYourAccount = '/create-your-account';
  static String forgetPasswordScreen = '/forget-password-screen';
  static String otpVerificationScreen = '/otp-verification-screen';
  static String setNewPassword = '/set-new-password';
  static String home = '/home';
  static String products = '/products';
  static String frenchies = '/frenchies';
  static String bottomNavigationBar = '/bottom-navigation-bar';
  static String shoppingCard = '/shopping-card';
  static String checkOut = '/check-out';
  static String adminBottomBar = '/admin-bottom-bar';
  static String userDashboard = '/user-dashboard';
  static String viewDetails = '/view-details';
  static String addUsers = '/add-users';
  static String cashbook = '/cashbook';
  static String viewNetbanking = '/view-netbanking';
  static String createCashbookEntry = '/create-cashbook-entry';
  static String categories = '/categories';
  static String categoriesDetail = '/categories-detail';
  static String createCategory = '/create-category';
  static String productsTab = '/products-tab';
  static String productDetails = '/frenchies-details';
  static String createProduct = '/create-frenchies';
  static String generalVouchers = '/general-vouchers';
  static String viewVouchers = '/view-vouchers';
  static String b2bOrder = '/b2b-order';
  static String b2bUser = '/b2b-user';
  static String createNewb2bUser = '/create-new-b2b-user';
  static String createNewb2bOrder = '/create-new-b2b-order';
  static String invoice = '/invoice';
  static String orderDetailScreen = '/order-detail-screen';
  static String addNewRawMaterial = '/add-new-raw-material';
  static String viewAllRawMaterial = '/view-all-raw-material';
  static String createNewSemiFinishedProductScreen =
      '/create-new-semi-finished-frenchies';
  static String viewAllSemiFinishedMaterial =
      '/view-all-semi-finished-material';
  static String createNewFinishedProduct = '/create-new-finished-frenchies';
  static String viewNewFinishedProductScreen =
      '/view-new-finished-frenchies-screen';
  static String viewStockMovementScreen = '/view-stock-movement';
  static String addStockMovement = '/add-stock-movement';
  static String addNewSupplier = '/add-new-supplier';
  static String viewAllSupplier = '/view-all-supplier';
  static String viewOrderAnalytics = '/order-analytics';
  static String orderAnalyticsInvoice = '/order-analytics-invoice';
  static String allOrders = '/all-orders';
  static String allOrdersDetailScreen = '/all-orders-detail-screen';
  static String customerDetailScreen = '/customer-detail-screen';
  static String viewCustomerDetailScreen = '/view-customer-detail-screen';
  static String customerOrder = '/customer-order';
  static String viewCustomerOrder = '/view-customer-order';
  static String customerOrderInvoice = '/customer-order-invoice';
  static String addVoucherScreen = '/add-voucher-screen';
  static String rawMaterial = '/raw-material';
  static String semiFinished = '/semi-finished';
  static String finishedGoods = '/finished-goods';
  static String stockMovement = '/stock-movement';
  static String supplierScreen = '/supplier-screen';
  static String orderAnalytics = '/order-analytics';

  static List<GetPage> myRoutes = [
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: createYourAccount, page: () => const CreateYourAccount()),
    GetPage(
      name: forgetPasswordScreen,
      page: () => const ForgetPasswordScreen(),
    ),
    GetPage(
      name: otpVerificationScreen,
      page: () => const OtpVerificationScreen(),
    ),
    GetPage(name: setNewPassword, page: () => const SetNewPassword()),
    GetPage(name: home, page: () => const Home()),
    GetPage(name: frenchies, page: () => Frenchies()),
    GetPage(name: products, page: () => Products()),
    GetPage(
      name: bottomNavigationBar,
      page: () => const BottomNavigationBarScreen(),
    ),
    GetPage(name: shoppingCard, page: () => ShoppingCardScreen()),
    GetPage(name: checkOut, page: () => const CheckoutScreen()),
    GetPage(name: adminBottomBar, page: () => const AdminBottomBarScreen()),
    GetPage(name: userDashboard, page: () => UserDashboardScreen()),
    GetPage(
      name: viewDetails,
      page: () {
        final userCode = Get.arguments as String;
        return ViewDetailsScreen(userCode: userCode);
      },
    ),
    GetPage(name: addUsers, page: () => CreateNewUserScreen()),
    GetPage(name: cashbook, page: () => const CashbookScreen()),
    GetPage(name: viewNetbanking, page: () => const ViewNetbankingScreen()),
    GetPage(
      name: createCashbookEntry,
      page: () => const CreateCashbookEntryScreen(),
    ),
    GetPage(name: categories, page: () => CategoriesScreen()),
    GetPage(name: categoriesDetail, page: () => const CategoryDetailsScreen()),
    GetPage(name: createCategory, page: () => CreateNewCategoryScreen()),
    GetPage(name: productsTab, page: () => ProductsScreen()),
    GetPage(name: productDetails, page: () => ProductDetailsScreen()),
    GetPage(name: createProduct, page: () => CreateProductScreen()),
    GetPage(name: generalVouchers, page: () => GeneralVouchersScreen()),
    GetPage(name: viewVouchers, page: () => ViewVouchersScreen()),
    GetPage(name: b2bOrder, page: () => const B2BOrderScreen()),
    GetPage(name: b2bUser, page: () => B2BUserScreen()),
    GetPage(name: createNewb2bUser, page: () => CreateNewB2BUser()),
    GetPage(name: createNewb2bOrder, page: () => CreateNewB2BOrder()),
    GetPage(name: invoice, page: () => const InvoiceScreen()),
    GetPage(
      name: orderDetailScreen,
      page: () {
        final order = Get.arguments as B2BOrder;
        return OrderDetailScreen(order: order);
      },
    ),

    GetPage(name: addNewRawMaterial, page: () => const AddNewRawMaterial()),
    GetPage(name: viewAllRawMaterial, page: () => const ViewAllRawMaterial()),
    GetPage(
      name: createNewSemiFinishedProductScreen,
      page: () => CreateNewSemiFinishedProductScreen(),
    ),
    GetPage(
      name: viewAllSemiFinishedMaterial,
      page: () => ViewAllSemiFinishedMaterial(),
    ),
    GetPage(
      name: createNewFinishedProduct,
      page: () => CreateNewFinishedProductScreen(),
    ),
    GetPage(
      name: viewNewFinishedProductScreen,
      page: () => ViewNewFinishedProductScreen(),
    ),
    GetPage(
      name: viewStockMovementScreen,
      page: () => ViewStockMovementScreen(),
    ),
    GetPage(name: addStockMovement, page: () => AddStockMovementScreen()),
    GetPage(name: addNewSupplier, page: () => AddNewSupplier()),
    GetPage(name: viewAllSupplier, page: () => ViewSupplierScreen()),
    GetPage(name: viewOrderAnalytics, page: () => const ViewOrderAnalytics()),
    GetPage(name: orderAnalyticsInvoice, page: () => OrderAnalyticsInvoice()),
    GetPage(name: allOrders, page: () => AllOrders()),
    GetPage(
      name: allOrdersDetailScreen,
      page: () => const AllOrdersDetailScreen(),
    ),
    GetPage(
      name: customerDetailScreen,
      page: () => const CustomerDetailScreen(),
    ),
    GetPage(
      name: viewCustomerDetailScreen,
      page: () => const ViewCustomerDetailScreen(),
    ),
    GetPage(name: customerOrder, page: () => const CustomerOrder()),
    GetPage(name: viewCustomerOrder, page: () => ViewCustomerOrder()),
    GetPage(
      name: customerOrderInvoice,
      page: () => const CustomerOrderInvoice(),
    ),
    GetPage(name: addVoucherScreen, page: () => AddVouchersScreen()),
    GetPage(name: rawMaterial, page: () => RawMaterialScreen()),
    GetPage(name: semiFinished, page: () => SemiFinishedMaterial()),
    GetPage(name: finishedGoods, page: () => FinishedGoodsScreen()),
    GetPage(name: stockMovement, page: () => StockMovementScreen()),
    GetPage(name: supplierScreen, page: () => SupplierScreen()),
    GetPage(name: orderAnalytics, page: () => const OrderAnalytics()),
  ];
}
