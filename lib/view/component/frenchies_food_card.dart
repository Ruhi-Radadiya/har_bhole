import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color mainOrange = Color(0xffF78520);
const Color greenRating = Color(0xFF1D653D);
const Color greyDetails = Color(0xff767676);
const Color blueOfferDot = Color(0xFF42A5F5);

class SmallFoodItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String timeDistance;
  final String rating;
  final String offerBadgeText;
  final VoidCallback? onTap;

  const SmallFoodItemCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.timeDistance,
    this.rating = '4.0',
    required this.offerBadgeText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double w = Get.width;

    final double cardWidth = w * 0.45;
    final double borderRadius = w / 30;
    final double paddingMain = w / 40;
    final double imageRatio = 0.6;
    final double titleFontSize = w / 28;
    final double detailFontSize = w / 35;
    final double iconSize = w / 35;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        margin: EdgeInsets.only(right: w / 25), // Spacing between cards
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: w / 60,
              offset: Offset(0, w / 120),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Image Section ---
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(borderRadius),
                  ),
                  child: Image.asset(
                    imageUrl,
                    height: cardWidth * imageRatio,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Offer Badge
                Positioned(
                  top: paddingMain / 1.5,
                  left: paddingMain / 1.5,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: w / 50,
                      vertical: w / 100,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(w / 80),
                    ),
                    child: Text(
                      offerBadgeText,
                      style: GoogleFonts.poppins(
                        fontSize: w / 38,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: w / 40,
                  left: paddingMain / 1.5,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: w / 50,
                      vertical: w / 100,
                    ),
                    decoration: BoxDecoration(
                      color: greenRating,
                      borderRadius: BorderRadius.circular(w / 30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, color: Colors.white, size: iconSize),
                        SizedBox(width: w / 100),
                        Text(
                          rating,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: detailFontSize,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: w / 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingMain),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: w / 100),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: iconSize,
                        color: greyDetails,
                      ),
                      SizedBox(width: w / 100),
                      Text(
                        timeDistance,
                        style: GoogleFonts.poppins(
                          fontSize: detailFontSize,
                          color: greyDetails,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: w / 40), // Space at bottom of card
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
