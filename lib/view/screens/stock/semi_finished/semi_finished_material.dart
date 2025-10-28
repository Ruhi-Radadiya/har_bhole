import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/main.dart';
import 'package:har_bhole/view/screens/stock/semi_finished/view_all_semi_finished_material.dart';

import '../../../../model/semi_finished_material_model/semi_finished_material_model.dart';
import '../../../../routes/routes.dart';
import '../../../component/textfield.dart';

class SemiFinishedMaterial extends StatelessWidget {
  const SemiFinishedMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    const Color mainOrange = Color(0xffF78520);
    semiFinishedController.searchMaterial('');
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                              'Semi Finished Materials',
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
                              'Manage all Semi Finished Materials',
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
                          Get.toNamed(
                            Routes.createNewSemiFinishedProductScreen,
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
                          'Add Semi Finished Materials',
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
                padding: EdgeInsets.symmetric(horizontal: Get.width / 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height / 30),
                    _buildInfoGridFromApi(),
                    SizedBox(height: Get.height / 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'All Semi Finished Materials',
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
                    Container(
                      padding: EdgeInsets.all(Get.width / 20),
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
                            hint: "Search Material",
                            icon: Icons.search,
                            onChanged: (value) {
                              semiFinishedController.searchMaterial(value);
                            },
                          ),
                          SizedBox(height: Get.height / 80),
                          const Divider(height: 1, color: Color(0xffF2F3F5)),
                          Obx(() {
                            if (semiFinishedController.isLoading.value) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xffF78520),
                                ),
                              );
                            }
                            if (semiFinishedController
                                .errorMessage
                                .isNotEmpty) {
                              return Center(
                                child: Text(
                                  semiFinishedController.errorMessage.value,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              );
                            }
                            if (semiFinishedController
                                .filteredMaterials
                                .isEmpty) {
                              return const Center(
                                child: Text('No categories found'),
                              );
                            }
                            return Column(
                              children: List.generate(
                                semiFinishedController.filteredMaterials.length,
                                (index) {
                                  final item = semiFinishedController
                                      .filteredMaterials[index];
                                  return Column(
                                    children: [
                                      _buildCategoryTile(item),
                                      if (index !=
                                          semiFinishedController
                                                  .filteredMaterials
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
      ),
    );
  }

  Widget _buildFilterDropdown({required String label}) {
    return Container(
      width: Get.width / 3.6,
      height: Get.height / 22,
      padding: EdgeInsets.symmetric(horizontal: Get.width / 50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: Get.width / 40,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildFilterField({required String label, required Widget child}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: Get.width / 30,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 6),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoGridFromApi() {
    int parseQty(String? qty) {
      if (qty == null) return 0;
      // Parse string like "12.000" to int
      return (double.tryParse(qty) ?? 0).toInt();
    }

    return Obx(() {
      final infoData = [
        {
          'count': semiFinishedController.materials.length.toString(),
          'label': 'Total item',
        },
        {
          'count': semiFinishedController.materials
              .where((item) => parseQty(item.currentQuantity as String?) > 0)
              .length
              .toString(),
          'label': 'In Stock',
        },
        {
          'count': semiFinishedController.materials
              .where(
                (item) =>
                    parseQty(item.currentQuantity as String?) > 0 &&
                    parseQty(item.currentQuantity as String?) < 5,
              )
              .length
              .toString(),
          'label': 'Low Stock',
        },
        {
          'count': semiFinishedController.materials
              .where((item) => parseQty(item.currentQuantity as String?) == 0)
              .length
              .toString(),
          'label': 'Out Of Stock',
        },
      ];

      return _buildInfoGrid(infoData);
    });
  }

  Widget _buildInfoGrid(List<Map<String, String>> data) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: Get.height / 80,
        crossAxisSpacing: Get.width / 25,
        childAspectRatio: 1.2,
      ),
      itemBuilder: (context, index) {
        final item = data[index];
        return _buildInfoCard(item['count']!, item['label']!);
      },
    );
  }

  Widget _buildInfoCard(String count, String label) {
    double size = Get.width / 3.5; // square dimension

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.09),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(Get.width / 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              count,
              style: GoogleFonts.poppins(
                fontSize: Get.width / 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: Get.height / 150),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: Get.width / 32,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTile(SemiFinishedMaterialModel item) {
    double qty = double.tryParse(item.currentQuantity ?? "0") ?? 0;
    bool inStock = qty > 0;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height / 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
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
          Flexible(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.itemName ?? '',
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
                        item.description ?? '',
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: inStock
                      ? const Color(0xffDCE1D7) // Light green
                      : const Color(0xffEFCFD2), // Light red
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text(
                  inStock ? "In Stock" : "Out of Stock",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: Get.width / 36,
                      fontWeight: FontWeight.bold,
                      color: inStock
                          ? const Color(0xff4E6B37) // Dark green
                          : const Color(0xffAD111E), // Dark red
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height / 200),
              GestureDetector(
                onTap: () {
                  log(
                    '🧾 ${item.itemName} - Quantity: ${item.currentQuantity}',
                  );

                  Get.to(() => ViewAllSemiFinishedMaterial(), arguments: item);
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
