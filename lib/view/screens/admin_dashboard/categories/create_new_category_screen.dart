import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../../../main.dart';
import '../../../../model/home_page_models/premium_collection_model.dart';
import '../../../../view/component/textfield.dart';

class CreateNewCategoryScreen extends StatefulWidget {
  const CreateNewCategoryScreen({super.key});

  @override
  State<CreateNewCategoryScreen> createState() =>
      _CreateNewCategoryScreenState();
}

class _CreateNewCategoryScreenState extends State<CreateNewCategoryScreen> {
  final TextEditingController _categoryCodeController = TextEditingController();
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _sortOrderController = TextEditingController(
    text: "1",
  );

  var selectedCategoryType = "Main".obs;
  var selectedStatus = "Active".obs;
  var showOnHome = "Yes".obs;
  String categoryImage = "default.png";

  @override
  void initState() {
    super.initState();
    _generateNextCategoryCode();
  }

  Future<void> _generateNextCategoryCode() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://harbhole.eihlims.com/Api/category_api.php?action=list',
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final items = data['items'] as List<dynamic>;

        // Filter only codes starting with 'CAT'
        final catCodes = items
            .map((e) => e['category_code'].toString())
            .where((code) => code.startsWith('CAT'))
            .toList();

        if (catCodes.isEmpty) {
          _categoryCodeController.text = "CAT0001";
          return;
        }

        // Extract numeric parts and find max
        final numbers = <int>[];
        for (var code in catCodes) {
          final numericPart = code.replaceAll(RegExp(r'[^0-9]'), '');
          if (numericPart.isNotEmpty) {
            numbers.add(int.parse(numericPart));
          }
        }

        final maxNum = numbers.isNotEmpty
            ? numbers.reduce((a, b) => a > b ? a : b)
            : 0;
        _categoryCodeController.text =
            'CAT${(maxNum + 1).toString().padLeft(4, '0')}';
      } else {
        _categoryCodeController.text = "CAT0001";
      }
    } catch (e) {
      _categoryCodeController.text = "CAT0001";
      print("Error generating next category code: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color mainOrange = Color(0xffF78520);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color(0xffF78520),
                        ),
                        onPressed: () => Get.back(),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(minWidth: Get.width / 15),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Create New Category',
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
                padding: EdgeInsets.all(Get.width / 30),
                child: Container(
                  padding: EdgeInsets.all(Get.width / 20),
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
                      CustomDropdownField<String>(
                        label: "Category Type",
                        hint: "Select Category Type",
                        items: ["Main", "Sub"],
                        value: selectedCategoryType.value,
                        getLabel: (item) => item,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedCategoryType.value = value;
                            });
                          }
                        },
                      ),

                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        hint: "Enter Category Name",
                        label: "Category Name",
                        controller: _categoryNameController,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        hint: "Auto-generated",
                        label: "Category Code",
                        controller: _categoryCodeController,
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        hint: "Enter Category Description",
                        label: "Description",
                        controller: _descriptionController,
                        maxLines: 3,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField<String>(
                        label: "Status",
                        hint: "Active",
                        items: ["Active", "Inactive"],
                        value: selectedStatus.value,
                        getLabel: (item) => item,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedStatus.value = value;
                            });
                          }
                        },
                      ),

                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        hint: "1",
                        label: "Sort Order",
                        controller: _sortOrderController,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomDropdownField<String>(
                        label: "Show on Homepage",
                        hint: "Yes/No",
                        items: ["Yes", "No"],
                        value: showOnHome.value,
                        getLabel: (item) => item,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              showOnHome.value = value;
                            });
                          }
                        },
                      ),
                      SizedBox(height: Get.height / 60),
                      UploadFileField(
                        label: "Category Image",
                        onFileSelected: (file) {
                          categoryImage = file.split("/").last;
                        },
                      ),
                      SizedBox(height: Get.height / 50),
                      Obx(
                        () => createCategoryController.isLoading.value
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: mainOrange,
                                ),
                              )
                            : SizedBox(
                                height: Get.height / 18,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final category = PremiumCollectionModel(
                                      categoryId: '',
                                      categoryName: _categoryNameController.text
                                          .trim(),
                                      categoryCode: _categoryCodeController.text
                                          .trim(),
                                      description: _descriptionController.text
                                          .trim(),
                                      parentId: null,
                                      status: selectedStatus == "Active"
                                          ? "1"
                                          : "0",
                                      sortOrder: _sortOrderController.text
                                          .trim(),
                                      categoryImage: categoryImage,
                                      createdAt: "",
                                      updatedAt: "",
                                      showOnHome: showOnHome == "Yes"
                                          ? "1"
                                          : "0",
                                    );

                                    final success =
                                        await createCategoryController
                                            .createCategory(category);
                                    if (success) {
                                      Get.snackbar(
                                        "Success",
                                        "Category created successfully",
                                        backgroundColor: Colors.green,
                                        colorText: Colors.white,
                                      );

                                      // Refresh categories list
                                      await premiumCollectionController
                                          .fetchPremiumCollection();

                                      Get.back(); // Go back to Categories screen
                                    } else {
                                      Get.snackbar(
                                        "Error",
                                        "Failed to create category",
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: mainOrange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  child: Text(
                                    'Create Category',
                                    style: GoogleFonts.poppins(
                                      fontSize: Get.width / 22.5,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      SizedBox(height: Get.height / 80),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: Get.height / 20),
          ],
        ),
      ),
    );
  }
}

/// Controller for Create Category
class CreateCategoryController extends GetxController {
  static CreateCategoryController get instance => Get.find();

  RxBool isLoading = false.obs;
  final String apiUrl =
      "https://harbhole.eihlims.com/Api/category_api.php?action=add";

  Future<bool> createCategory(PremiumCollectionModel category) async {
    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "category_name": category.categoryName,
          "category_code": category.categoryCode,
          "description": category.description,
          "parent_id": category.parentId,
          "status": int.tryParse(category.status) ?? 1,
          "sort_order": int.tryParse(category.sortOrder) ?? 1,
          "show_on_home": int.tryParse(category.showOnHome) ?? 1,
          "category_image": category.categoryImage,
        }),
      );

      isLoading.value = false;
      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        return res['success'] == true;
      }
      return false;
    } catch (e) {
      isLoading.value = false;
      print("Error creating category: $e");
      return false;
    }
  }
}
