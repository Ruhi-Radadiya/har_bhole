import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../main.dart';
import '../../../../model/home_page_models/premium_collection_model.dart';

class CategoryDetailsScreen extends StatelessWidget {
  const CategoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color mainOrange = Color(0xffF78520);

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
                          'Category Details',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: Get.width / 18,
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
              padding: EdgeInsets.all(Get.width / 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0), // Standard radius
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
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Image.asset(
                        'asset/images/home/khaman.png',
                        width: double.infinity,
                        height: Get.height / 4,

                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: Get.height / 100,
                        left: Get.width / 25,
                        right: Get.width / 25,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: Get.height / 30),
                          _buildDetailField(
                            label: 'Category Name',
                            value: 'Namkeen',
                          ),
                          _buildDetailField(
                            label: 'Category Type',
                            value: 'Main Category',
                          ),
                          _buildDetailField(
                            label: 'Category Code',
                            value: 'CAT007',
                          ),
                          _buildDetailField(label: 'Sort Order', value: '4'),
                          _buildDetailField(
                            label: 'Description',
                            value: 'Crispy and Savory Namkeen',
                            maxLines: 2,
                          ),
                          _buildDetailField(
                            label: 'Created Date',
                            value: 'September 10, 2025 at 10:22 Am',
                          ),
                          SizedBox(height: Get.height / 50),
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
                                  textStyle: TextStyle(
                                    fontSize: Get.width / 22.5,
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
                              onPressed: () async {
                                // Get selected category from Get.arguments
                                final category =
                                    Get.arguments as PremiumCollectionModel;
                                final categoryId = category.categoryId;

                                // Call delete
                                bool success = await deleteCategoryController
                                    .deleteCategory(categoryId);

                                if (success) {
                                  // Remove deleted category from the list (optional)

                                  premiumCollectionController.premiumCollection
                                      .removeWhere(
                                        (cat) => cat.categoryId == categoryId,
                                      );
                                  premiumCollectionController.filteredCategories
                                      .removeWhere(
                                        (cat) => cat.categoryId == categoryId,
                                      );

                                  Get.back(); // Close details screen
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: const BorderSide(
                                  color: Color(0xffF78520),
                                  width: 1,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              child: Text(
                                'Delete',
                                style: TextStyle(color: Color(0xffF78520)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: Get.height / 30),
        ],
      ),
    );
  }

  Widget _buildDetailField({
    required String label,
    required String value,
    int maxLines = 1,
  }) {
    final double fieldHeight = maxLines > 1 ? Get.height / 10 : Get.height / 20;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: Get.width / 26,
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
            vertical: Get.height / 100,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffF3F7FC),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            value,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: Get.width / 30,
              ),
            ),
          ),
        ),
        SizedBox(height: Get.height / 50),
      ],
    );
  }
}
