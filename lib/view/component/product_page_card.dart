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
    return Padding(
      padding: EdgeInsets.all(Get.width / 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: const AssetImage("asset/images/home/veg_icon.png"),
                  height: Get.width / 22,
                ),
                SizedBox(height: Get.width / 90),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: Get.width / 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      height: 1.2,
                    ),
                  ),
                ),
                SizedBox(height: Get.width / 100),
                Text(
                  price,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: Get.width / 28,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: Get.width / 40),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: Get.width / 34,
                      color: Colors.grey.shade700,
                      height: 1.3,
                    ),
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          SizedBox(width: Get.width / 25),
          ClipRRect(
            borderRadius: BorderRadius.circular(Get.width / 40),
            child: Container(
              width: Get.width / 2.8,
              height: Get.width / 3.6,
              color: Colors.grey.shade100,
              child: imageUrl.isNotEmpty
                  ? Image.asset(imageUrl, fit: BoxFit.cover)
                  : Center(
                      child: Icon(
                        Icons.fastfood,
                        size: Get.width / 10,
                        color: Colors.grey.shade400,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
