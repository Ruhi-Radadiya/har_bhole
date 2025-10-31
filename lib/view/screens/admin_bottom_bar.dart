import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:har_bhole/view/screens/b2b/b2b.dart';
import 'package:har_bhole/view/screens/order/order.dart';
import 'package:har_bhole/view/screens/stock/stock.dart';

import '../../controller/login_controller.dart';
import '../../main.dart';
import 'admin_dashboard/admin_dashboard.dart';

class AdminBottomBarScreen extends StatefulWidget {
  const AdminBottomBarScreen({super.key});

  @override
  State<AdminBottomBarScreen> createState() => _AdminBottomBarScreenState();
}

class _AdminBottomBarScreenState extends State<AdminBottomBarScreen> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // ✅ Role check (admin vs customer)
      final isAdmin = loginController.userRole.value == UserRole.admin;

      // ✅ Show pages based on role
      final pages = isAdmin
          ? const [AdminDashboard(), B2B(), Stock(), Order()]
          : const [AdminDashboard()];

      // ✅ Bottom bar items based on role
      final items = isAdmin
          ? [
              _bottomItem("asset/images/dashboard_image.png", "Dashboard", 0),
              _bottomItem("asset/images/b2b_image.png", "B2B", 1),
              _bottomItem("asset/images/stocks_image.png", "Stock", 2),
              _bottomItem("asset/images/orders_image.png", "Order", 3),
            ]
          : [_bottomItem("asset/images/dashboard_image.png", "Dashboard", 0)];

      return Scaffold(
        body: PageView(
          controller: userDashboardController.pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            userDashboardController.getIndex(index: index);
          },
          children: pages,
        ),
        bottomNavigationBar: Obx(() {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color(0xffFFFFFF),
            selectedItemColor: const Color(0xffF78520),
            unselectedItemColor: const Color(0xff9EA4B0),
            currentIndex: userDashboardController.bottomNavigationIndex.value,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Get.width / 28,
            ),
            unselectedLabelStyle: const TextStyle(fontSize: 12),
            onTap: (value) {
              // Prevent customer from tapping unavailable tabs
              if (!isAdmin && value > 0) {
                Fluttertoast.showToast(msg: "Access restricted to admin only");
                return;
              }

              userDashboardController.getIndex(index: value);
              userDashboardController.changePageView(index: value);
            },
            items: items,
          );
        }),
      );
    });
  }

  BottomNavigationBarItem _bottomItem(String icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        icon,
        height: Get.width / 22,
        color: userDashboardController.bottomNavigationIndex.value == index
            ? const Color(0xffF78520)
            : const Color(0xff9EA4B0),
      ),
      label: label,
    );
  }
}
