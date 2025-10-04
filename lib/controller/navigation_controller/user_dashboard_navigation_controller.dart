import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDashboardController extends GetxController {
  // same name as your old NavigationController
  RxInt bottomNavigationIndex = 0.obs;
  PageController pageController = PageController(initialPage: 0);

  // same as old getIndex
  void getIndex({required int index}) {
    bottomNavigationIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
  }

  // same as old changePageView
  void changePageView({required int index}) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}
