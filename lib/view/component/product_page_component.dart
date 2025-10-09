import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodItemContainer extends StatelessWidget {
  final String title;
  final String price;
  final String description;
  final int quantity;
  final String imageUrl;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;

  const FoodItemContainer({
    super.key,
    required this.title,
    required this.price,
    required this.description,
    required this.quantity,
    this.imageUrl = '',
    this.onAdd,
    this.onRemove,
  });

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
        children: [
          // LEFT — Texts
          Expanded(
            flex: 2,
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
                    Image(
                      image: AssetImage("asset/images/home/share.png"),
                      height: Get.width / 22,
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(width: Get.width * 0.04),

          // RIGHT — Image + Add Button or Counter
          Column(
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
                          color: Colors.orange,
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
                        color: Colors.orange,
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
