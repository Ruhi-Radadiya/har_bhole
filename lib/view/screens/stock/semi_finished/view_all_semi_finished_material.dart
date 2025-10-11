import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../main.dart';
import '../../../component/textfield.dart';

class ViewAllSemiFinishedMaterial extends StatelessWidget {
  const ViewAllSemiFinishedMaterial({super.key});
  final Color mainOrange = const Color(0xffF78520);
  final Color inStockGreen = const Color(0xff4F6B1F);
  final Color lowStockYellow = const Color(0xffFFC107);
  final Color outOfStockRed = const Color(0xffFF3B30);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(Get.width / 30),
              child: Column(
                children: [
                  _buildInfoGridFromApi(),
                  SizedBox(height: Get.height / 30),
                  Container(
                    padding: EdgeInsets.all(Get.width / 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Semi-Finished Materials',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: Get.width / 22.5,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffF78520),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  child: Container(
                                    padding: const EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xffF78520),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(
                                        color: Color(0xffF78520),
                                        fontWeight: FontWeight.bold,
                                        fontSize: Get.width / 36,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: Get.width / 100),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xffF78520),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'cancel',
                                    style: TextStyle(
                                      color: Color(0xffF78520),
                                      fontWeight: FontWeight.bold,
                                      fontSize: Get.width / 36,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height / 50),

                        // --- Dropdown Filters ---
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildFilterField(
                              label: "Search",
                              child: _buildFilterDropdown(label: "Code/Name"),
                            ),
                            _buildFilterField(
                              label: "Category",
                              child: _buildFilterDropdown(
                                label: "All Category",
                              ),
                            ),
                            _buildFilterField(
                              label: "Unit",
                              child: _buildFilterDropdown(label: "All Units"),
                            ),
                          ],
                        ),

                        SizedBox(height: Get.height / 50),
                        Obx(() {
                          if (semiFinishedController.isLoading.value) {
                            return CircularProgressIndicator();
                          }

                          return Column(
                            children: semiFinishedController.materials.map((
                              material,
                            ) {
                              return Column(
                                children: [
                                  CustomTextField(
                                    label: 'Code',
                                    hint: material.itemCode,
                                    isReadOnly: true,
                                  ),
                                  SizedBox(height: Get.height / 60),
                                  CustomTextField(
                                    label: 'Name',
                                    hint: material.itemName,
                                    isReadOnly: true,
                                  ),
                                  SizedBox(height: Get.height / 60),
                                  CustomTextField(
                                    label: 'Category',
                                    hint: material.categoryId,
                                    isReadOnly: true,
                                  ),
                                  SizedBox(height: Get.height / 60),
                                  CustomTextField(
                                    label: 'BOM',
                                    hint:
                                        '${material.bomItems.length.toString()} items',
                                    isReadOnly: true,
                                  ),
                                  SizedBox(height: Get.height / 60),
                                  CustomTextField(
                                    label: 'Current Stock',
                                    hint:
                                        '${material.currentQuantity} ${material.unitOfMeasure}',
                                    isReadOnly: true,
                                  ),
                                  SizedBox(height: Get.height / 60),
                                  CustomTextField(
                                    label: 'Unit',
                                    hint: material.unitOfMeasure,
                                    isReadOnly: true,
                                  ),
                                  SizedBox(height: Get.height / 60),
                                  CustomTextField(
                                    label: 'Output Type',
                                    hint: material.outputType,
                                    isReadOnly: true,
                                  ),
                                  SizedBox(height: Get.height / 60),
                                  CustomTextField(
                                    label: 'Box Weight (kg)',
                                    hint: '${material.boxWeight}',
                                    isReadOnly: true,
                                  ),
                                  SizedBox(height: Get.height / 60),
                                  CustomTextField(
                                    label: 'Box Dimensions',
                                    hint: material.boxDimensions,
                                    isReadOnly: true,
                                  ),
                                  SizedBox(height: Get.height / 50),
                                  const Divider(),
                                  SizedBox(height: Get.height / 50),
                                ],
                              );
                            }).toList(),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Get.height / 20),
        ],
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
}
