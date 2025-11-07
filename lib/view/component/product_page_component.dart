import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class FoodItemContainer extends StatefulWidget {
  final String title;
  final String productId;
  final String price;
  final String description;
  final int quantity;
  final String imageUrl;
  final bool isFromSavedPage;
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
    this.isFromSavedPage = false,
    this.onAdd,
    this.onRemove,
    this.onShare,
  });

  @override
  State<FoodItemContainer> createState() => _FoodItemContainerState();
}

class _FoodItemContainerState extends State<FoodItemContainer> {
  final box = GetStorage();
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    final savedList = box.read<List>('savedProducts') ?? [];
    isSaved = savedList.any((p) => p['productId'] == widget.productId);
  }

  void toggleSave() {
    List savedList = box.read<List>('savedProducts') ?? [];

    if (isSaved) {
      savedList.removeWhere((p) => p['productId'] == widget.productId);
      Fluttertoast.showToast(
        msg: "Removed from Saved",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
      );
    } else {
      savedList.add({
        'title': widget.title,
        'productId': widget.productId,
        'price': widget.price,
        'description': widget.description,
        'imageUrl': widget.imageUrl,
      });
      Fluttertoast.showToast(
        msg: "Saved Successfully",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: const Color(0xff4E6B37),
        textColor: Colors.white,
      );
    }

    box.write('savedProducts', savedList);
    setState(() => isSaved = !isSaved);
  }

  Future<void> shareProduct() async {
    try {
      StringBuffer shareText = StringBuffer();
      shareText.writeln("🍽️ ${widget.title}");
      shareText.writeln("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
      shareText.writeln();
      shareText.writeln("💰 Price: ${widget.price}");
      shareText.writeln();
      final String deepLink =
          "https://harbhole.eihlims.com/product?id=${widget.productId}";
      shareText.writeln("🔗 $deepLink");
      shareText.writeln();
      if (widget.description.isNotEmpty) {
        shareText.writeln("📝 Description:");
        shareText.writeln(widget.description);
        shareText.writeln();
      }
      shareText.writeln("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
      shareText.writeln();
      shareText.writeln("From Har Bhole - Your Farsan Business Hub");

      await Share.share(
        shareText.toString(),
        subject: 'Check out this product: ${widget.title}',
      );

      Fluttertoast.showToast(
        msg: "Product shared successfully!",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: const Color(0xff4E6B37),
        textColor: Colors.white,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Unable to share product",
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: const Color(0xffB52934),
        textColor: Colors.white,
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
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: Get.width / 40,
            offset: Offset(0, Get.height / 200),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
                  widget.title,
                  style: GoogleFonts.poppins(
                    fontSize: Get.width / 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: Get.height / 300),
                Text(
                  widget.price,
                  style: GoogleFonts.poppins(
                    fontSize: Get.width / 26,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade700,
                  ),
                ),
                SizedBox(height: Get.height / 150),
                Text(
                  widget.description,
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
                    if (!widget.isFromSavedPage)
                      GestureDetector(
                        onTap: toggleSave,
                        child: Icon(
                          isSaved ? Icons.bookmark : Icons.bookmark_border,
                          color: isSaved ? Colors.black : Colors.black,
                          size: Get.width / 18,
                        ),
                      ),
                    SizedBox(width: Get.width / 25),
                    if (!widget.isFromSavedPage)
                      GestureDetector(
                        onTap: widget.onShare ?? shareProduct,
                        child: Image.asset(
                          "asset/images/home/share.png",
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
          Flexible(
            flex: 2,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Get.width / 30),
                  child: Image.asset(
                    widget.imageUrl,
                    width: Get.width / 2.8,
                    height: Get.width / 3.5,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: Get.height / 100),
                widget.quantity == 0
                    ? GestureDetector(
                        onTap: widget.onAdd,
                        child: Container(
                          width: Get.width / 2.8,
                          height: Get.height / 25,
                          decoration: BoxDecoration(
                            color: const Color(0xffF78520),
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
                          color: const Color(0xffF78520),
                          borderRadius: BorderRadius.circular(Get.width / 40),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: widget.onRemove,
                              child: Container(
                                padding: EdgeInsets.all(Get.width / 100),
                                child: Icon(
                                  Icons.remove,
                                  size: Get.width / 25,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              '${widget.quantity}',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: Get.width / 28,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            GestureDetector(
                              onTap: widget.onAdd,
                              child: Container(
                                padding: EdgeInsets.all(Get.width / 100),
                                child: Icon(
                                  Icons.add,
                                  size: Get.width / 25,
                                  color: Colors.white,
                                ),
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
