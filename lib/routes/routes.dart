import 'package:get/get.dart';
import 'package:har_bhole/view/screens/shopping/shopping_card.dart';
import 'package:har_bhole/view/screens/special/special.dart';

import '../view/screens/about/about.dart';
import '../view/screens/admin_bottom_bar.dart';
import '../view/screens/b2b_order/b2b_order_screen.dart';
import '../view/screens/b2b_order/create_new_b2b_order.dart';
import '../view/screens/b2b_users/b2b_user_screen.dart';
import '../view/screens/b2b_users/create_new_b2b_user.dart';
import '../view/screens/bottom_navigation_bar.dart';
import '../view/screens/cashbook/cashbook_screen.dart';
import '../view/screens/cashbook/creat_cashbook_entry.dart';
import '../view/screens/cashbook/view_net_banking.dart';
import '../view/screens/categories/categories_screen.dart';
import '../view/screens/categories/categoris_detail_screen.dart';
import '../view/screens/categories/create_new_category_screen.dart';
import '../view/screens/contact/contact.dart';
import '../view/screens/create_your_account/create_your_account.dart';
import '../view/screens/forget_password_screen/forget_password_screen.dart';
import '../view/screens/home/home.dart';
import '../view/screens/login_screen/login_screen.dart';
import '../view/screens/otp_screen/otp_screen.dart';
import '../view/screens/product/product.dart';
import '../view/screens/products/create_new_product_screen.dart';
import '../view/screens/products/product_detail_screen.dart';
import '../view/screens/products/products_screen.dart';
import '../view/screens/set_new_password/set_new_password.dart';
import '../view/screens/shopping/checkout.dart';
import '../view/screens/user_dashboard_screen/add_user_screen.dart';
import '../view/screens/user_dashboard_screen/user_dashboard_screen.dart';
import '../view/screens/user_dashboard_screen/view_details_screen.dart';
import '../view/screens/voucher/general_voucher_screen.dart';
import '../view/screens/voucher/view_voucher.dart';

class Routes {
  static String loginScreen = '/login-screen';
  static String createYourAccount = '/create-your-account';
  static String forgetPasswordScreen = '/forget-password-screen';
  static String otpVerificationScreen = '/otp-verification-screen';
  static String setNewPassword = '/set-new-password';
  static String home = '/home';
  static String about = '/about';
  static String contact = '/contact';
  static String product = '/product';
  static String special = '/special';
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
  static String productDetails = '/product-details';
  static String createProduct = '/create-product';
  static String generalVouchers = '/general-vouchers';
  static String viewVouchers = '/view-vouchers';
  static String b2bOrder = '/b2b-order';
  static String b2bUser = '/b2b-user';
  static String createNewb2bUser = '/create-new-b2b-user';
  static String createNewb2bOrder = '/create-new-b2b-order';

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
    GetPage(name: about, page: () => const About()),
    GetPage(name: contact, page: () => const Contact()),
    GetPage(name: product, page: () => const Product()),
    GetPage(name: special, page: () => const Special()),
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
    GetPage(name: categories, page: () => const CategoriesScreen()),
    GetPage(name: categoriesDetail, page: () => const CategoryDetailsScreen()),
    GetPage(name: createCategory, page: () => CreateNewCategoryScreen()),
    GetPage(name: productsTab, page: () => ProductsScreen()),
    GetPage(name: productDetails, page: () => ProductDetailsScreen()),
    GetPage(name: createProduct, page: () => CreateProductScreen()),
    GetPage(name: generalVouchers, page: () => GeneralVouchersScreen()),
    GetPage(name: viewVouchers, page: () => ViewVouchersScreen()),
    GetPage(name: b2bOrder, page: () => const B2BOrderScreen()),
    GetPage(name: b2bUser, page: () => const B2BUserScreen()),
    GetPage(name: createNewb2bUser, page: () => CreateNewB2BUser()),
    GetPage(name: createNewb2bOrder, page: () => CreateNewB2BOrder()),
  ];
}
