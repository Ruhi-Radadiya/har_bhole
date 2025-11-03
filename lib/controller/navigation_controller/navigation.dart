import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxInt bottomNavigationIndex = 0.obs;
  late final PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
  }

  void getIndex({required int index}) {
    bottomNavigationIndex.value = index;
  }

  void changePageView({required int index}) {
    if (!pageController.hasClients) return; // Prevent error if not attached yet
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
