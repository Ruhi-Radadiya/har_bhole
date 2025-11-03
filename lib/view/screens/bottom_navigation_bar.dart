import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:har_bhole/view/screens/home/home.dart';
import 'package:har_bhole/view/screens/products/products.dart';

import '../../controller/navigation_controller/navigation.dart';
import 'frenchies/frenchies.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  NavigationController navigationController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: navigationController.pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          navigationController.getIndex(index: index);
        },
        children: [const Home(), Frenchies(), const Products()],
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xffFFFFFF),
          selectedItemColor: Color(0xffF78520),
          unselectedItemColor: Color(0xff9EA4B0),
          currentIndex: navigationController.bottomNavigationIndex.value,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Get.width / 28,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          onTap: (value) {
            navigationController.getIndex(index: value);
            navigationController.changePageView(index: value);
          },
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                "asset/icons/home.png",
                height: Get.width / 22,
                color: navigationController.bottomNavigationIndex.value == 0
                    ? Color(0xffF78520)
                    : Color(0xff9EA4B0),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "asset/icons/frenchie's.png",
                height: Get.width / 22,
                color: navigationController.bottomNavigationIndex.value == 1
                    ? Color(0xffF78520)
                    : Color(0xff9EA4B0),
              ),
              label: "Frenchie's",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "asset/icons/products.png",
                height: Get.width / 22,
                color: navigationController.bottomNavigationIndex.value == 2
                    ? Color(0xffF78520)
                    : Color(0xff9EA4B0),
              ),
              label: "Products",
            ),
          ],
        );
      }),
    );
  }
}
