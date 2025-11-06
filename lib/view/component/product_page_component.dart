import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class FoodItemContainer extends StatelessWidget {
  final String title;
  final String productId;
  final String price;
  final String description;
  final int quantity;
  final String imageUrl;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;
  final VoidCallback? onShare;

  const FoodItemContainer({
    super.key,
    required this.title,
    required this.productId,
    required this.price,
    required this.description,
    required this.quantity,
    this.imageUrl = '',
    this.onAdd,
    this.onRemove,
    this.onShare,
  });

  // Share individual product
  Future<void> shareProduct() async {
    try {
      log("🔄 Attempting to share product: $title");
      log("📱 Platform: ${Theme.of(Get.context!).platform}");

      StringBuffer shareText = StringBuffer();
      shareText.writeln("🍽️ $title");
      shareText.writeln("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
      shareText.writeln();
      shareText.writeln("💰 Price: $price");
      shareText.writeln();
      // Deep link (placeholder): Update to your real domain/app link handler
      final String deepLink =
          "https://harbhole.eihlims.com/product?id=$productId";
      shareText.writeln("🔗 $deepLink");
      shareText.writeln();
      if (description.isNotEmpty) {
        shareText.writeln("📝 Description:");
        shareText.writeln(description);
        shareText.writeln();
      }
      shareText.writeln("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
      shareText.writeln();
      shareText.writeln("From Har Bhole - Your Farsan Business Hub");

      log("📝 Share text prepared: ${shareText.length} characters");

      // Try to share - use Share.share() with proper error handling
      final result =
          await Share.share(
            shareText.toString(),
            subject: 'Check out this product: $title',
          ).timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw TimeoutException('Share operation timed out');
            },
          );

      log("📤 Share completed with status: ${result.status}");

      log("✅ Product shared successfully: $title");

      // Show success toast
      Fluttertoast.showToast(
        msg: "Product shared successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xff4E6B37),
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } catch (e, stackTrace) {
      log("❌ Error sharing product: $e", error: e, stackTrace: stackTrace);
      log("❌ Error type: ${e.runtimeType}");
      log("❌ Stack trace: $stackTrace");

      String errorMessage = "Unable to share product";

      // Check for specific exception types
      final errorString = e.toString().toLowerCase();

      if (errorString.contains("missingpluginexception") ||
          errorString.contains("no implementation found") ||
          errorString.contains("method not found") ||
          errorString.contains("platform channel not found")) {
        errorMessage =
            "Share feature not available. Please restart the app and try again.";
        log(
          "⚠️ Missing plugin exception detected - share_plus may not be properly initialized",
        );
        log(
          "💡 Solution: Run 'flutter pub get' and restart the app completely",
        );
      } else if (errorString.contains("platformexception")) {
        // Check if it's a specific platform exception
        if (errorString.contains("not implemented") ||
            errorString.contains("unavailable")) {
          errorMessage = "Share feature is not available on this platform.";
        } else {
          errorMessage =
              "Share feature encountered an error. Please try again.";
        }
      } else if (errorString.contains("permission") ||
          errorString.contains("denied")) {
        errorMessage = "Permission denied. Please check app permissions.";
      } else {
        // Generic error - show the actual error for debugging
        errorMessage = "Unable to share: ${e.toString().split(':').first}";
        if (errorMessage.length > 50) {
          errorMessage = "Unable to share product. Please try again.";
        }
      }

      // Show error toast with better styling
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xffB52934),
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      margin: EdgeInsets.symmetric(
        horizontal: Get.width * 0.05,
        vertical: Get.height / 120,
      ),
      padding: EdgeInsets.all(Get.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Get.width / 30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: Get.width / 40,
            offset: Offset(0, Get.height / 200),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          // LEFT — Texts
          Flexible(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "asset/images/home/veg_icon.png",
                  height: Get.width / 22,
                ),
                SizedBox(height: Get.height / 200),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: Get.width / 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: Get.height / 300),
                Text(
                  price,
                  style: GoogleFonts.poppins(
                    fontSize: Get.width / 26,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade700,
                  ),
                ),
                SizedBox(height: Get.height / 150),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: Get.width / 34,
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: Get.height / 80),
                Row(
                  children: [
                    Image(
                      image: AssetImage("asset/images/home/tag.png"),
                      height: Get.width / 22,
                      color: Colors.black,
                    ),
                    SizedBox(width: Get.width / 25),
                    GestureDetector(
                      onTap: onShare ?? shareProduct,

                      child: Image(
                        image: AssetImage("asset/images/home/share.png"),
                        height: Get.width / 22,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: Get.width * 0.04),
          // RIGHT — Image + Add Button or Counter
          Flexible(
            flex: 2,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Get.width / 30),
                  child: Image.asset(
                    imageUrl,
                    width: Get.width / 2.8,
                    height: Get.width / 3.5,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: Get.height / 100),
                quantity == 0
                    ? GestureDetector(
                        onTap: onAdd,
                        child: Container(
                          width: Get.width / 2.8,
                          height: Get.height / 25,
                          decoration: BoxDecoration(
                            color: Color(0xffF78520),
                            borderRadius: BorderRadius.circular(Get.width / 40),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Add to Cart",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: Get.width / 30,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: Get.width / 2.8,
                        height: Get.height / 25,
                        decoration: BoxDecoration(
                          color: Color(0xffF78520),
                          borderRadius: BorderRadius.circular(Get.width / 40),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: onRemove,
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: Get.width / 24,
                              ),
                            ),
                            Text(
                              "$quantity",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: Get.width / 30,
                              ),
                            ),
                            GestureDetector(
                              onTap: onAdd,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: Get.width / 24,
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem {
  final String title;
  final String imageUrl;
  final String price;
  final String description;

  MenuItem({
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.description,
  });
}

class FoodSection {
  FoodSection({
    required this.title,
    required this.items,
    this.isExpanded = false,
  });

  String title;
  List<MenuItem> items;
  bool isExpanded;
}
