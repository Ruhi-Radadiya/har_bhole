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
    UserDashboardController controller = Get.put(UserDashboardController());

    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          controller.getIndex(index: index);
        },
        children: const [AdminDashboard(), B2B(), Stock(), Order()],
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xffFFFFFF),
          selectedItemColor: Color(0xffF78520),
          unselectedItemColor: Color(0xff9EA4B0),
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
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                "asset/images/dashboard_image.png",
                height: Get.width / 22,
                color: controller.bottomNavigationIndex.value == 0
                    ? Color(0xffF78520)
                    : Color(0xff9EA4B0),
              ),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "asset/images/b2b_image.png",
                height: Get.width / 22,
                color: controller.bottomNavigationIndex.value == 1
                    ? Color(0xffF78520)
                    : Color(0xff9EA4B0),
              ),
              label: "B2B",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "asset/images/stocks_image.png",
                height: Get.width / 22,
                color: controller.bottomNavigationIndex.value == 2
                    ? Color(0xffF78520)
                    : Color(0xff9EA4B0),
              ),
              label: "Stock",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "asset/images/orders_image.png",
                height: Get.width / 22,
                color: controller.bottomNavigationIndex.value == 3
                    ? Color(0xffF78520)
                    : Color(0xff9EA4B0),
              ),
              label: "Order",
            ),
          ],
        );
      }),
    );
  }
}
