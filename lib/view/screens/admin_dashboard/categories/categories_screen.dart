import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../main.dart';
import '../../../../model/home_page_models/premium_collection_model.dart';
import '../../../../routes/routes.dart';
import '../../../component/textfield.dart';
import 'categoris_detail_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color mainOrange = Color(0xffF78520);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header & Add Button ---
            Container(
              padding: EdgeInsets.only(
                top: Get.height / 25,
                left: Get.width / 25,
                right: Get.width / 25,
                bottom: Get.height / 50,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  colors: [Color(0xffFFE1C7), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 1.0],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height / 100),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: Color(0xffFAD6B5),
                          shape: BoxShape.circle,
                        ),
                        child: SizedBox(
                          height: Get.width / 15,
                          width: Get.width / 15,
                          child: Image.asset('asset/icons/users_icon.png'),
                        ),
                      ),
                      SizedBox(width: Get.width / 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Categories',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: Get.width / 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height / 200),
                          Text(
                            'Manage all categories',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: Get.width / 28,
                                color: Color(0xff4A4541),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height / 50),
                  SizedBox(
                    height: Get.height / 18,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to create category screen
                        Get.toNamed(Routes.createCategory);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Add Categories',
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
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width / 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height / 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'All Categories',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: Get.width / 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff747784),
                          ),
                        ),
                      ),
                      Text(
                        'View All',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: Get.width / 26,
                            fontWeight: FontWeight.w500,
                            color: mainOrange,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height / 50),

                  // --- Search & List ---
                  Container(
                    padding: EdgeInsets.all(Get.width / 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        CustomTextField(
                          hint: "Search Categories",
                          icon: Icons.search,
                          onChanged: (value) {
                            premiumCollectionController.searchCategories(value);
                          },
                        ),
                        SizedBox(height: Get.height / 80),
                        const Divider(height: 1, color: Color(0xffF2F3F5)),

                        Obx(() {
                          if (premiumCollectionController.isLoading.value) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (premiumCollectionController
                              .errorMessage
                              .isNotEmpty) {
                            return Center(
                              child: Text(
                                premiumCollectionController.errorMessage.value,
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                          }

                          if (premiumCollectionController
                              .filteredCategories
                              .isEmpty) {
                            return const Center(
                              child: Text('No categories found'),
                            );
                          }

                          return Column(
                            children: List.generate(
                              premiumCollectionController
                                  .filteredCategories
                                  .length,
                              (index) {
                                final item = premiumCollectionController
                                    .filteredCategories[index];

                                return Column(
                                  children: [
                                    _buildCategoryTile(item),
                                    if (index !=
                                        premiumCollectionController
                                                .filteredCategories
                                                .length -
                                            1)
                                      const Divider(
                                        height: 1,
                                        color: Color(0xffF2F3F5),
                                      ),
                                  ],
                                );
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height / 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTile(PremiumCollectionModel item) {
    const Color mainOrange = Color(0xffF78520);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height / 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // --- Category Info ---
          Flexible(
            child: Row(
              children: [
                Container(
                  width: Get.width / 8,
                  height: Get.width / 8,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15.0),
                    image: const DecorationImage(
                      image: AssetImage('asset/images/about/jalebi.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: Get.width / 30),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.categoryName,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: Get.width / 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        item.description,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: Get.width / 34.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // --- Status & Actions ---
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: item.status == "1"
                      ? const Color(0xffDCE1D7)
                      : const Color(0xffEFCFD2),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text(
                  item.status == "1" ? "Active" : "Inactive",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: Get.width / 36,
                      fontWeight: FontWeight.bold,
                      color: item.status == "1"
                          ? const Color(0xff4E6B37)
                          : const Color(0xffAD111E),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height / 200),
              GestureDetector(
                onTap: () {
                  // Navigate to details screen with the selected category
                  Get.to(() => CategoryDetailsScreen(), arguments: item);
                },
                child: Text(
                  'View Details',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: Get.width / 36,
                      color: const Color(0xff2A86D1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
