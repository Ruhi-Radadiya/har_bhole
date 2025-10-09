import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  // Helper for a single detail field (label and value) - Copied from previous logic
  Widget _buildDetailField({
    required String label,
    required String value,
    int maxLines = 1,
    Color valueColor =
        Colors.black, // Added for Stock Status / Selling Price color
  }) {
    // Height calculation based on maxLines, similar to previous text fields
    final double fieldHeight = maxLines > 1 ? Get.height / 10 : Get.height / 20;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 14, // Standard font size
              fontWeight: FontWeight.w500,
              color: Color(0xff000000),
            ),
          ),
        ),
        SizedBox(height: Get.height / 150),

        Container(
          height: fieldHeight,
          alignment: maxLines > 1 ? Alignment.topLeft : Alignment.centerLeft,
          padding: EdgeInsets.symmetric(
            horizontal: Get.width / 25,
            vertical: Get.height / 100, // Small vertical padding for text
          ),
          decoration: BoxDecoration(
            color: const Color(0xffF3F7FC), // Light grey background
            borderRadius: BorderRadius.circular(12.0), // Standard radius
          ),
          child: Text(
            value,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: valueColor,
                fontSize: Get.width / 30, // Text size relative to width
                fontWeight: valueColor == Colors.black
                    ? FontWeight.normal
                    : FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: Get.height / 50), // Space between fields
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color mainOrange = Color(0xffF78520);
    const Color stockGreen = Color(0xff4CAF50); // Color for 'In Stock'

    return Scaffold(
      backgroundColor: Colors.grey.shade100, // Main background
      body: Column(
        children: [
          SizedBox(height: Get.height / 30),
          Container(
            padding: EdgeInsets.only(
              left: Get.width / 25,
              right: Get.width / 25,
              bottom: Get.height / 100,
            ),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                SizedBox(height: Get.height / 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Get.back(),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(minWidth: Get.width / 15),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          // --- UPDATED TITLE ---
                          'Product Details',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20, // Standard font size
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width / 15), // Placeholder
                  ],
                ),
              ],
            ),
          ),
          // --- Main Content Area ---
          Expanded(
            child: SingleChildScrollView(
              // The padding here is slightly large in your snippet, adjusted to look closer to image
              padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
              child: Column(
                children: [
                  Container(
                    // Padding around the card to make it look floating, but the card itself is not padded
                    margin: EdgeInsets.symmetric(vertical: Get.height / 50),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        20.0,
                      ), // Standard radius
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- Product Image ---
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          child: Image.asset(
                            'asset/images/home/samosa.png',
                            width: double.infinity,
                            height: Get.height / 4,
                            fit: BoxFit.cover,
                          ),
                        ),

                        Padding(
                          // This padding wraps the form fields inside the white card
                          padding: EdgeInsets.only(
                            top: Get.height / 40,
                            bottom: Get.height / 40,
                            left: Get.width / 25,
                            right: Get.width / 25,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rajvadi Peda',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height / 30),

                              _buildDetailField(
                                label: 'Product Code',
                                value: '25110048',
                              ),

                              _buildDetailField(
                                label: 'Stock Quantity',
                                value: '0',
                              ),

                              _buildDetailField(
                                label: 'Net Weight',
                                value: '1000.000g',
                              ),

                              _buildDetailField(
                                label: 'Category',
                                value: 'Sweet',
                              ),

                              _buildDetailField(
                                label: 'Stock Status',
                                value: 'In Stock',
                                valueColor: Color(0xff2E8755),
                              ),

                              _buildDetailField(
                                label: 'Selling Price',
                                value: '₹500.00',
                                valueColor: Color(0xff2E8755),
                              ),

                              SizedBox(
                                height: Get.height / 18,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: mainOrange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    'Edit',
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        fontSize: 16, // Standard font size
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height / 80),
                              SizedBox(
                                height: Get.height / 18,
                                width: double.infinity,
                                child: OutlinedButton(
                                  onPressed: () {
                                    /* Delete Product Logic */
                                  },
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    side: const BorderSide(
                                      color: mainOrange,
                                      width: 1,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    'Delete',
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        fontSize: 16, // Standard font size
                                        color: mainOrange,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
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
            ),
          ),
          SizedBox(height: Get.height / 30),
        ],
      ),
    );
  }
}
