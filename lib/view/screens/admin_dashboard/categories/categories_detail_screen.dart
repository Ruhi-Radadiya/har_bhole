import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../main.dart';
import '../../../../model/home_page_models/premium_collection_model.dart';
import '../../../../view/component/textfield.dart';
import 'create_new_category_screen.dart';

class CategoryDetailsScreen extends StatelessWidget {
  const CategoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color mainOrange = Color(0xffF78520);

    final PremiumCollectionModel category =
        Get.arguments as PremiumCollectionModel;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
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
                    SizedBox(width: Get.width / 15),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(Get.width / 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
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
                      borderRadius: const BorderRadius.only(
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
                      padding: EdgeInsets.symmetric(
                        horizontal: Get.width / 25,
                        vertical: Get.height / 50,
                      ),
                      child: Column(
                        children: [
                          CustomTextField(
                            hint: '',
                            label: "Category Name",
                            controller: TextEditingController(
                              text: category.categoryName,
                            ),
                            isReadOnly: true,
                          ),
                          SizedBox(height: Get.height / 60),
                          CustomTextField(
                            hint: '',

                            label: "Category Type",
                            controller: TextEditingController(
                              text: category.parentId == null
                                  ? 'Main Category'
                                  : 'Sub Category',
                            ),
                            isReadOnly: true,
                          ),
                          SizedBox(height: Get.height / 60),
                          CustomTextField(
                            hint: '',

                            label: "Category Code",
                            controller: TextEditingController(
                              text: category.categoryCode,
                            ),
                            isReadOnly: true,
                          ),
                          SizedBox(height: Get.height / 60),
                          CustomTextField(
                            hint: '',

                            label: "Sort Order",
                            controller: TextEditingController(
                              text: category.sortOrder,
                            ),
                            isReadOnly: true,
                          ),
                          SizedBox(height: Get.height / 60),
                          CustomTextField(
                            hint: '',

                            label: "Description",
                            controller: TextEditingController(
                              text: category.description,
                            ),
                            isReadOnly: true,
                            maxLines: 2,
                          ),
                          SizedBox(height: Get.height / 60),
                          CustomTextField(
                            hint: '',
                            label: "Status",
                            controller: TextEditingController(
                              text: category.status == '1'
                                  ? 'Active'
                                  : 'Inactive',
                            ),
                            isReadOnly: true,
                          ),
                          SizedBox(height: Get.height / 60),
                          CustomTextField(
                            hint: '',
                            label: "Show on Home",
                            controller: TextEditingController(
                              text: category.showOnHome == '1' ? 'Yes' : 'No',
                            ),
                            isReadOnly: true,
                          ),
                          SizedBox(height: Get.height / 60),
                          CustomTextField(
                            hint: '',

                            label: "Created Date",
                            controller: TextEditingController(
                              text: category.createdAt,
                            ),
                            isReadOnly: true,
                          ),
                          SizedBox(height: Get.height / 50),
                          SizedBox(
                            height: Get.height / 18,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(
                                  () => CreateNewCategoryScreen(
                                    existingCategory: category,
                                  ),
                                );
                              },
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
                          SizedBox(height: Get.height / 50),
                          SizedBox(
                            height: Get.height / 18,
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () async {
                                // Show confirmation dialog
                                await Get.defaultDialog(
                                  title: "Delete Category",
                                  titleStyle: TextStyle(
                                    color: const Color(0xffF78520),
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.width / 20,
                                  ),
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  barrierDismissible: false,
                                  content: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Get.width / 20,
                                      vertical: Get.height / 50,
                                    ),
                                    child: Text(
                                      "Are you sure you want to delete this category?",
                                      style: TextStyle(
                                        color: const Color(0xffF78520),
                                        fontSize: Get.width / 30,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  textConfirm: "Yes",
                                  textCancel: "No",
                                  confirmTextColor: const Color(0xffF78520),
                                  cancelTextColor: const Color(0xffF78520),
                                  buttonColor: Colors.white,
                                  onConfirm: () async {
                                    // Call delete function
                                    bool success =
                                        await deleteCategoryController
                                            .deleteCategory(
                                              category.categoryId,
                                            );

                                    if (success) {
                                      // Remove category from lists locally
                                      premiumCollectionController
                                          .premiumCollection
                                          .removeWhere(
                                            (cat) =>
                                                cat.categoryId ==
                                                category.categoryId,
                                          );
                                      premiumCollectionController
                                          .filteredCategories
                                          .removeWhere(
                                            (cat) =>
                                                cat.categoryId ==
                                                category.categoryId,
                                          );

                                      // Close dialog
                                      if (Get.isDialogOpen ?? false) Get.back();
                                    }
                                  },
                                  onCancel: () {
                                    if (Get.isDialogOpen ?? false) Get.back();
                                  },
                                );
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
                              child: const Text(
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
}
