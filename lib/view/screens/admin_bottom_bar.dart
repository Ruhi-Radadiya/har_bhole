import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:har_bhole/controller/navigation_controller/user_dashboard_navigation_controller.dart';
import 'package:har_bhole/view/screens/b2b/b2b.dart';
import 'package:har_bhole/view/screens/order/order.dart';
import 'package:har_bhole/view/screens/stock/stock.dart';

import 'admin_dashboard/admin_dashboard.dart';

class AdminBottomBarScreen extends StatefulWidget {
  const AdminBottomBarScreen({super.key});

  @override
  State<AdminBottomBarScreen> createState() => _AdminBottomBarScreenState();
}

class _AdminBottomBarScreenState extends State<AdminBottomBarScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserDashboardController());

    // ✅ Pages to show
    final pages = const [AdminDashboard(), B2B(), Stock(), Order()];

    // ✅ BottomNavigationBar items
    final items = [
      _bottomItem(
        controller,
        "asset/images/dashboard_image.png",
        "Dashboard",
        0,
      ),
      _bottomItem(controller, "asset/images/b2b_image.png", "B2B", 1),
      _bottomItem(controller, "asset/images/stocks_image.png", "Stock", 2),
      _bottomItem(controller, "asset/images/orders_image.png", "Order", 3),
    ];

    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) => controller.getIndex(index: index),
        children: pages,
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xffFFFFFF),
          selectedItemColor: const Color(0xffF78520),
          unselectedItemColor: const Color(0xff9EA4B0),
          currentIndex: controller.bottomNavigationIndex.value,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Get.width / 28,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          onTap: (value) {
            controller.getIndex(index: value);
            controller.changePageView(index: value);
          },
          items: items,
        );
      }),
    );
  }

  BottomNavigationBarItem _bottomItem(
    UserDashboardController controller,
    String icon,
    String label,
    int index,
  ) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        icon,
        height: Get.width / 22,
        color: controller.bottomNavigationIndex.value == index
            ? const Color(0xffF78520)
            : const Color(0xff9EA4B0),
      ),
      label: label,
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:har_bhole/controller/navigation_controller/user_dashboard_navigation_controller.dart';
// import 'package:har_bhole/view/screens/b2b/b2b.dart';
// import 'package:har_bhole/view/screens/order/order.dart';
// import 'package:har_bhole/view/screens/stock/stock.dart';
//
// import '../../controller/login_controller.dart';
// import '../../main.dart';
// import 'admin_dashboard/admin_dashboard.dart';
//
// class AdminBottomBarScreen extends StatefulWidget {
//   const AdminBottomBarScreen({super.key});
//
//   @override
//   State<AdminBottomBarScreen> createState() => _AdminBottomBarScreenState();
// }
//
// class _AdminBottomBarScreenState extends State<AdminBottomBarScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(UserDashboardController());
//
//     return Obx(() {
//       // ✅ Check role
//       final isAdmin = loginController.userRole.value == UserRole.admin;
//
//       // ✅ Pages and nav items based on role
//       final pages = isAdmin
//           ? const [AdminDashboard(), B2B(), Stock(), Order()]
//           : const [AdminDashboard()];
//
//       final items = isAdmin
//           ? [
//               _bottomItem(
//                 controller,
//                 "asset/images/dashboard_image.png",
//                 "Dashboard",
//                 0,
//               ),
//               _bottomItem(controller, "asset/images/b2b_image.png", "B2B", 1),
//               _bottomItem(
//                 controller,
//                 "asset/images/stocks_image.png",
//                 "Stock",
//                 2,
//               ),
//               _bottomItem(
//                 controller,
//                 "asset/images/orders_image.png",
//                 "Order",
//                 3,
//               ),
//             ]
//           : [
//               _bottomItem(
//                 controller,
//                 "asset/images/dashboard_image.png",
//                 "Dashboard",
//                 0,
//               ),
//             ];
//
//       return Scaffold(
//         body: PageView(
//           controller: controller.pageController,
//           physics: const NeverScrollableScrollPhysics(),
//           onPageChanged: (index) => controller.getIndex(index: index),
//           children: pages,
//         ),
//         bottomNavigationBar: isAdmin
//             ? Obx(() {
//                 return BottomNavigationBar(
//                   type: BottomNavigationBarType.fixed,
//                   backgroundColor: const Color(0xffFFFFFF),
//                   selectedItemColor: const Color(0xffF78520),
//                   unselectedItemColor: const Color(0xff9EA4B0),
//                   currentIndex: controller.bottomNavigationIndex.value,
//                   selectedLabelStyle: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: Get.width / 28,
//                   ),
//                   unselectedLabelStyle: const TextStyle(fontSize: 12),
//                   onTap: (value) {
//                     controller.getIndex(index: value);
//                     controller.changePageView(index: value);
//                   },
//                   items: items,
//                 );
//               })
//             : null, // 👈 hide bar if not admin
//       );
//     });
//   }
//
//   BottomNavigationBarItem _bottomItem(
//     UserDashboardController controller,
//     String icon,
//     String label,
//     int index,
//   ) {
//     return BottomNavigationBarItem(
//       icon: Image.asset(
//         icon,
//         height: Get.width / 22,
//         color: controller.bottomNavigationIndex.value == index
//             ? const Color(0xffF78520)
//             : const Color(0xff9EA4B0),
//       ),
//       label: label,
//     );
//   }
// }
