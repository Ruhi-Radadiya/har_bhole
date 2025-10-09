import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/routes/routes.dart';

import '../../component/product_page_component.dart';

class Products extends StatefulWidget {
  final String? defaultType;
  const Products({super.key, this.defaultType});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final Map<String, int> cart = {};

  final List<FoodSection> sections = [
    FoodSection(
      title: 'Recommended for you',
      isExpanded: true,
      items: [
        MenuItem(
          title: 'Farali Petis',
          imageUrl: 'asset/images/home/khaman.png',
          price: '₹ 220',
          description:
              'Traditional Gujarati snack with a French twist, light, crispy, and perfect for tea time.',
        ),
        MenuItem(
          title: 'Rajavadi Petis',
          imageUrl: 'asset/images/home/khaman.png',
          price: '₹ 220',
          description:
              'Traditional Gujarati snack with a French twist, light, crispy, and perfect for tea time.',
        ),
      ],
    ),
    FoodSection(
      title: 'Om Her Bhole Special',
      items: [
        MenuItem(
          title: 'Farali Petis',
          imageUrl: 'asset/images/home/khaman.png',
          price: '₹ 220',
          description: 'Special edition snack, rich in flavor and texture.',
        ),
      ],
    ),
    FoodSection(
      title: 'Hot Snacks',
      items: [
        MenuItem(
          title: 'Samosa',
          imageUrl: 'asset/images/home/khaman.png',
          price: '₹ 40',
          description: 'Crispy pastry with spicy potato filling.',
        ),
      ],
    ),
    FoodSection(
      title: 'Sweet',
      items: [
        MenuItem(
          title: 'Jalebi',
          imageUrl: 'asset/images/home/khaman.png',
          price: '₹ 150',
          description: 'Crispy pretzel-shaped deep-fried sweet.',
        ),
      ],
    ),
    FoodSection(
      title: 'Namkeen',
      items: [
        MenuItem(
          title: 'Chakri',
          imageUrl: 'asset/images/home/khaman.png',
          price: '₹ 200',
          description: 'Spicy, spiral-shaped crunchy snack.',
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.defaultType != null) {
      final indexToOpen = sections.indexWhere(
        (section) => section.title == widget.defaultType,
      );
      if (indexToOpen != -1) {
        for (var s in sections) {
          s.isExpanded = false;
        }
        sections[indexToOpen].isExpanded = true;
      }
    }
  }

  void toggleSection(int index) {
    setState(() {
      for (int i = 0; i < sections.length; i++) {
        if (i != index) sections[i].isExpanded = false;
      }
      sections[index].isExpanded = !sections[index].isExpanded;
    });
  }

  void addToCart(String title) {
    setState(() {
      cart[title] = (cart[title] ?? 0) + 1;
    });
  }

  void removeFromCart(String title) {
    setState(() {
      if (cart.containsKey(title)) {
        cart[title] = cart[title]! - 1;
        if (cart[title]! <= 0) {
          cart.remove(title);
        }
      }
    });
  }

  int get totalItemsInCart =>
      cart.values.fold(0, (previous, current) => previous + current);

  // ---------------------------------------------------------------------------
  // BUILD UI
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfffefefe),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: totalItemsInCart > 0 ? 80 : 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔍 Search Bar Row
                  Padding(
                    padding: EdgeInsets.all(Get.width / 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: Get.width / 40,
                              bottom: Get.height / 100,
                            ),
                            child: Container(
                              height: Get.height / 16,
                              padding: EdgeInsets.symmetric(
                                horizontal: Get.width / 25,
                                vertical: Get.height / 100,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  Get.width / 27,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    blurRadius: Get.width / 50,
                                    offset: Offset(0, Get.height / 200),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "asset/icons/search.png",
                                    height: Get.width / 22,
                                  ),
                                  SizedBox(width: Get.width / 40),
                                  Expanded(
                                    child: TextField(
                                      style: GoogleFonts.poppins(
                                        fontSize: Get.width / 28,
                                        color: Colors.black87,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Search "papad poha"',
                                        hintStyle: GoogleFonts.poppins(
                                          fontSize: Get.width / 28,
                                          color: Colors.grey.shade600,
                                        ),
                                        border: InputBorder.none,
                                        isDense: true,
                                      ),
                                    ),
                                  ),
                                  Image.asset(
                                    "asset/icons/microphone.png",
                                    height: Get.width / 22,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: Get.width / 20),
                        Image.asset(
                          "asset/images/home/3_dot.png",
                          height: Get.width / 15,
                        ),
                      ],
                    ),
                  ),

                  // 📦 Collapsible Sections
                  Column(
                    children: sections
                        .asMap()
                        .entries
                        .map(
                          (entry) =>
                              buildCollapsibleSection(entry.value, entry.key),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),

            // 🛒 Bottom Cart Summary
            if (totalItemsInCart > 0)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: Get.height / 12,
                  margin: EdgeInsets.all(Get.width / 25),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(Get.width / 25),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Get.width / 25,
                        ),
                        child: Text(
                          "$totalItemsInCart item${totalItemsInCart > 1 ? 's' : ''} added",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: Get.width / 26,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.checkOut);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: Get.width / 25),
                          child: Row(
                            children: [
                              Text(
                                "View cart",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right_outlined,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildCollapsibleSection(FoodSection section, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => toggleSection(index),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Get.width / 30,
              vertical: Get.height / 70,
            ),
            color: Colors.grey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  section.title,
                  style: TextStyle(
                    fontSize: Get.width / 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  section.isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: Get.width / 18,
                ),
              ],
            ),
          ),
        ),

        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          sizeCurve: Curves.easeInOut,
          crossFadeState: section.isExpanded
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: Column(
            children: section.items.map((item) {
              final quantity = cart[item.title] ?? 0;
              return FoodItemContainer(
                imageUrl: item.imageUrl,
                title: item.title,
                price: item.price,
                description: item.description,
                quantity: quantity,
                onAdd: () => addToCart(item.title),
                onRemove: () => removeFromCart(item.title),
              );
            }).toList(),
          ),
          secondChild: const SizedBox.shrink(),
        ),

        Divider(height: Get.height / 200),
      ],
    );
  }
}
