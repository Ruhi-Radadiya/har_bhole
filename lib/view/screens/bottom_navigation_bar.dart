import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:har_bhole/view/screens/about/about.dart';
import 'package:har_bhole/view/screens/contact/contact.dart';
import 'package:har_bhole/view/screens/home/home.dart';
import 'package:har_bhole/view/screens/product/product.dart';
import 'package:har_bhole/view/screens/special/special.dart';

import '../../controller/navigation_controller/navigation.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  @override
  Widget build(BuildContext context) {
    NavigationController controller = Get.put(NavigationController());

    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          controller.getIndex(index: index);
        },
        children: const [Home(), Special(), About(), Product(), Contact()],
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xffFFFFFF),
          selectedItemColor: Color(0xffF78520),
          unselectedItemColor: Color(0xff9EA4B0),
          currentIndex: controller.bottomNavigationIndex.value,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          onTap: (value) {
            controller.getIndex(index: value);
            controller.changePageView(index: value);
          },
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                "asset/images/home.png",
                height: Get.width / 22,
                color: controller.bottomNavigationIndex.value == 0
                    ? Color(0xffF78520)
                    : Color(0xff9EA4B0),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "asset/images/special.png",
                height: Get.width / 22,
                color: controller.bottomNavigationIndex.value == 1
                    ? Color(0xffF78520)
                    : Color(0xff9EA4B0),
              ),
              label: "Special",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "asset/images/about.png",
                height: Get.width / 22,
                color: controller.bottomNavigationIndex.value == 2
                    ? Color(0xffF78520)
                    : Color(0xff9EA4B0),
              ),
              label: "About",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "asset/images/products.png",
                height: Get.width / 22,
                color: controller.bottomNavigationIndex.value == 3
                    ? Color(0xffF78520)
                    : Color(0xff9EA4B0),
              ),
              label: "Products",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "asset/images/contact.png",
                height: Get.width / 22,
                color: controller.bottomNavigationIndex.value == 4
                    ? Color(0xffF78520)
                    : Color(0xff9EA4B0),
              ),
              label: "Contact",
            ),
          ],
        );
      }),
    );
  }
}
