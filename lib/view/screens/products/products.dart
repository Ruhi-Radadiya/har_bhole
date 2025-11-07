import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/main.dart';
import 'package:har_bhole/routes/routes.dart';

import '../../../controller/product_controller/product_controller.dart';
import '../../component/product_page_component.dart';

class Products extends StatefulWidget {
  final String? defaultType;
  const Products({super.key, this.defaultType});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final ProductController controller = Get.put(ProductController());
  final Map<String, int> cart = {};
  final Map<String, bool> expanded = {};
  final ScrollController _scrollController = ScrollController();

  void toggleSection(String title) {
    setState(() {
      expanded[title] = !(expanded[title] ?? true);
    });
  }

  void addToCart(String productId, String price, String productName) async {
    const userId = "1";
    await orderCartController.addToCart(
      productId: productId,
      userId: userId,
      productName: productName,
    );
    setState(() {
      cart[productId] = (cart[productId] ?? 0) + 1;
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
  void expandCategoryForSearch(List<String> matchedCategories) {
    if (matchedCategories.isEmpty) {
      setState(() {
        for (var key in controller.groupedProducts.keys) {
          expanded[key] = false;
        }
      });
      return;
    }

    setState(() {
      for (var key in controller.groupedProducts.keys) {
        expanded[key] = matchedCategories.contains(key);
      }
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: const Color(0xfffefefe),
          body: Stack(
            children: [
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xffF78520)),
                  );
                }
                if (controller.errorMessage.isNotEmpty) {
                  return Center(child: Text(controller.errorMessage.value));
                }
                final grouped = controller.groupedProducts;
                grouped.keys.forEach((key) {
                  expanded.putIfAbsent(key, () => false);
                });
                return SingleChildScrollView(
                  controller: _scrollController,
                  padding: EdgeInsets.only(
                    bottom: totalItemsInCart > 0 ? 80 : 0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSearchBar(),
                      ...grouped.entries.map((entry) {
                        final title = entry.key;
                        final products = entry.value;
                        final isExpanded = expanded[title] ?? false;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => toggleSection(title),
                              child: Container(
                                color: Colors.grey.shade100,
                                padding: EdgeInsets.symmetric(
                                  horizontal: Get.width / 30,
                                  vertical: Get.height / 70,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      title,
                                      style: TextStyle(
                                        fontSize: Get.width / 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Icon(
                                      isExpanded
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            AnimatedCrossFade(
                              duration: const Duration(milliseconds: 300),
                              sizeCurve: Curves.easeInOut,
                              crossFadeState: isExpanded
                                  ? CrossFadeState.showFirst
                                  : CrossFadeState.showSecond,
                              firstChild: Column(
                                children: products.map((product) {
                                  final qty =
                                      cart[product.productId.toString()] ?? 0;
                                  return FoodItemContainer(
                                    productId: product.productId.toString(),
                                    title: product.productName,
                                    description: product.description,
                                    price: '₹ ${product.sellingPrice}',
                                    imageUrl:
                                        product.productImage ??
                                        'asset/images/home/khaman.png',
                                    quantity: qty,
                                    onAdd: () => addToCart(
                                      product.productId.toString(),
                                      product.sellingPrice.toString(),
                                      product.productName,
                                    ),
                                    onRemove: () =>
                                        removeFromCart(product.productName),
                                  );
                                }).toList(),
                              ),
                              secondChild: const SizedBox.shrink(),
                            ),
                            Divider(height: Get.height / 200),
                          ],
                        );
                      }),
                    ],
                  ),
                );
              }),

              // 🛒 Bottom Cart Summary
              if (totalItemsInCart > 0)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: Get.height / 12,
                    margin: EdgeInsets.all(Get.width / 25),
                    decoration: BoxDecoration(
                      color: const Color(0xffF78520),
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
                          onTap: () => Get.toNamed(Routes.checkOut),
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
                                const Icon(
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
      ),
    );
  }

  // 🔍 Search Bar
  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.all(Get.width / 30),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: Get.height / 16,
              padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Get.width / 27),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.4),
                    blurRadius: Get.width / 50,
                    offset: Offset(0, Get.height / 200),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Image.asset("asset/icons/search.png", height: Get.width / 22),
                  SizedBox(width: Get.width / 40),
                  Expanded(
                    child: TextField(
                      onChanged: (query) {
                        controller.searchProducts(query);
                        final matchedCategories = controller
                            .groupedProducts
                            .keys
                            .where(
                              (category) =>
                                  controller.groupedProducts[category]!.any(
                                    (p) => p.productName.toLowerCase().contains(
                                      query.toLowerCase(),
                                    ),
                                  ),
                            )
                            .toList();
                        expandCategoryForSearch(matchedCategories);
                      },
                      style: GoogleFonts.poppins(
                        fontSize: Get.width / 28,
                        color: Colors.black87,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Search products...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: Get.width / 40),
          IconButton(
            color: const Color(0xffF78520),
            onPressed: () {
              Get.toNamed(Routes.saveProductScreen);
            },
            icon: Icon(Icons.bookmark),
          ),
        ],
      ),
    );
  }
}
