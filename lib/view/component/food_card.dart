import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantFoodCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subDetails;
  final String offerText;
  final String rating;
  final String costPerOne;
  final VoidCallback? onTap;

  const RestaurantFoodCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subDetails,
    required this.offerText,
    this.rating = '4.0',
    this.costPerOne = '₹150 for one',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 7,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: Image.asset(
                    imageUrl,
                    height: Get.height / 4,
                    width: Get.width,
                    fit: BoxFit.cover,
                  ),
                ),
                // Pure Veg / Cost Overlay
                Positioned(
                  top: Get.height / 50,
                  left: Get.width / 20,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width / 40,
                      vertical: Get.width / 70,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(Get.width / 30),
                    ),
                    child: Text(
                      'Pure Veg, $costPerOne',
                      style: GoogleFonts.poppins(
                        fontSize: Get.width / 36,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                // Bookmark Icon
                Positioned(
                  top: 15,
                  right: 20,
                  child: Image(
                    image: AssetImage("asset/images/home/tag.png"),
                    height: Get.width / 15,
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.all(Get.width / 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: Get.width / 19,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: Get.width / 90,
                              vertical: Get.width / 120,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1D653D),
                              borderRadius: BorderRadius.circular(
                                Get.width / 30,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(Get.width / 150),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.star,
                                    color: const Color(0xFF1D653D),
                                    size: Get.width / 30,
                                  ),
                                ),
                                SizedBox(width: Get.width / 100),
                                Text(
                                  rating,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: Get.width / 33,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: Get.width / 100),
                              ],
                            ),
                          ),
                          Text(
                            "BY 100+",
                            style: GoogleFonts.poppins(
                              fontSize: Get.width / 36,
                              color: Color(0xff767676),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image(
                        image: AssetImage("asset/images/home/timer.png"),
                        height: Get.width / 30,
                      ),
                      SizedBox(width: Get.width / 60),
                      Text(
                        subDetails,
                        style: GoogleFonts.poppins(
                          fontSize: Get.width / 33,
                          color: Color(0xff767676),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height / 90),
                  Row(
                    children: [
                      Image(
                        image: AssetImage("asset/images/home/percantage.png"),
                        height: Get.width / 25,
                      ),
                      SizedBox(width: Get.width / 60),
                      Text(
                        offerText,
                        style: GoogleFonts.poppins(
                          fontSize: Get.width / 28,
                          color: Color(0xff767676),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
