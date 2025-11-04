import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:har_bhole/view/screens/home/home.dart';
import 'package:har_bhole/view/screens/products/products.dart';

import '../../main.dart';
import 'frenchies/frenchies.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          navigationController.getIndex(index: index);
        },
        children: [const Home(), Frenchies(), const Products()],
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xffF78520),
          unselectedItemColor: const Color(0xff9EA4B0),
          currentIndex: navigationController.bottomNavigationIndex.value,
          onTap: (value) {
            navigationController.getIndex(index: value);
            _pageController.animateToPage(
              value,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          },
          items: [
            _navItem("asset/icons/home.png", "Home", 0),
            _navItem("asset/icons/frenchie's.png", "Frenchie's", 1),
            _navItem("asset/icons/products.png", "Products", 2),
          ],
        );
      }),
    );
  }

  BottomNavigationBarItem _navItem(String iconPath, String label, int index) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        iconPath,
        height: Get.width / 22,
        color: navigationController.bottomNavigationIndex.value == index
            ? const Color(0xffF78520)
            : const Color(0xff9EA4B0),
      ),
      label: label,
    );
  }
}
