import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/main.dart';

import '../../../../model/finished_goods_stock/finished_goods_stock_model.dart';
import '../../../component/textfield.dart';

class ViewNewFinishedProductScreen extends StatefulWidget {
  const ViewNewFinishedProductScreen({super.key});

  @override
  State<ViewNewFinishedProductScreen> createState() =>
      _ViewNewFinishedProductScreenState();
}

class _ViewNewFinishedProductScreenState
    extends State<ViewNewFinishedProductScreen> {
  List<Map<String, String>> getInfoData() {
    final allItems = finishedGoodsStockController.finishedGoodsList;

    final totalItem = allItems.length;

    int inStockCount = 0;
    int outOfStockCount = 0;

    for (var item in allItems) {
      // Make sure currentQuantity is valid
      final qtyStr = item.currentQuantity ?? '0';
      final qty = int.tryParse(qtyStr.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

      if (qty > 0) {
        inStockCount++;
      } else {
        outOfStockCount++;
      }
    }

    return [
      {'count': totalItem.toString(), 'label': 'Total item'},
      {'count': inStockCount.toString(), 'label': 'In Stock'},
      {'count': outOfStockCount.toString(), 'label': 'Out of Stock'},
    ];
  }

  @override
  void initState() {
    super.initState();
    // Fetch once when screen is initialized
    finishedGoodsStockController.fetchFinishedGoodsStock();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (finishedGoodsStockController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xffF78520)),
          );
        }

        if (finishedGoodsStockController.finishedGoodsList.isEmpty) {
          return const Center(child: Text("No finished goods found"));
        }

        return Column(
          children: [
            SizedBox(height: Get.height / 30),
            Container(
              padding: EdgeInsets.only(
                left: Get.width / 25,
                right: Get.width / 25,
                bottom: Get.height / 100,
              ),
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
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
                  SizedBox(width: Get.width / 100),
                  Text(
                    'Finished Goods',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: Get.width / 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xffF78520),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(Get.width / 30),
                child: Column(
                  children: [
                    _buildInfoGrid(getInfoData()),
                    SizedBox(height: Get.height / 30),
                    ...finishedGoodsStockController.finishedGoodsList.map(
                      (product) => _buildProductCard(product),
                    ),

                    SizedBox(height: Get.height / 20),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildProductCard(FinishedGoodsStockModel product) {
    return Container(
      margin: EdgeInsets.only(bottom: Get.height / 30),
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
          // Title + Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Finished Goods',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: Get.width / 22.5,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffF78520),
                  ),
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffF78520)),
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
                      border: Border.all(color: Color(0xffF78520)),
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

          // Dropdown Filters (same as before)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFilterField(
                label: "Category",
                child: _buildFilterDropdown(label: "All categories"),
              ),
              _buildFilterField(
                label: "Status",
                child: _buildFilterDropdown(label: "All Status"),
              ),
              _buildFilterField(
                label: "Stock Status",
                child: _buildFilterDropdown(label: "All Stock"),
              ),
            ],
          ),
          SizedBox(height: Get.height / 50),

          // Product Data Fields
          CustomTextField(
            label: 'Code',
            hint: product.productCode ?? '-',
            isReadOnly: true,
            controller: TextEditingController(text: product.productCode ?? '-'),
          ),
          SizedBox(height: Get.height / 60),
          CustomTextField(
            label: 'Name',
            hint: product.productName ?? '-',
            isReadOnly: true,
            controller: TextEditingController(text: product.productName ?? '-'),
          ),
          SizedBox(height: Get.height / 60),
          CustomTextField(
            label: 'Category',
            hint: product.categoryName ?? '-',
            isReadOnly: true,
          ),
          SizedBox(height: Get.height / 60),
          _buildCurrentStockField(product.currentQuantity ?? '0'),
          SizedBox(height: Get.height / 60),
          CustomTextField(
            label: 'Cost/Unit',
            hint: product.producedTotalWeightGrams ?? '0',
            isReadOnly: true,
            controller: TextEditingController(
              text: product.producedTotalWeightGrams ?? '0',
            ),
          ),
          SizedBox(height: Get.height / 60),
          CustomTextField(
            label: 'Unit',
            hint: product.unitOfMeasure ?? '-',
            isReadOnly: true,
          ),
          _buildPagination(),
          SizedBox(height: Get.height / 100),
        ],
      ),
    );
  }

  // ───────────── Helpers ──────────────

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
    double size = Get.width / 3.5;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
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

  Widget _buildCurrentStockField(String stockQty) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Current Stock',
          style: TextStyle(
            fontSize: Get.width / 26,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        SizedBox(height: Get.height / 150),
        Container(
          height: Get.height / 20,
          padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
          decoration: BoxDecoration(
            color: const Color(0xffF3F7FC),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                stockQty,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: Get.width / 30,
                  ),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xff858585),
                size: 20,
              ),
            ],
          ),
        ),
        SizedBox(height: Get.height / 50),
      ],
    );
  }

  Widget _buildPagination() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height / 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _pageBtn(icon: Icons.keyboard_double_arrow_left),
          SizedBox(width: Get.width / 40),
          _pageCircle('1', true),
          SizedBox(width: Get.width / 40),
          _pageCircle('2', true),
          SizedBox(width: Get.width / 40),
          _pageBtn(icon: Icons.keyboard_double_arrow_right),
        ],
      ),
    );
  }

  Widget _pageBtn({required IconData icon}) => Container(
    width: Get.width / 13,
    height: Get.width / 13,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: const Color(0xffFAF7F6),
    ),
    child: Icon(icon, size: 19, color: Colors.black),
  );

  Widget _pageCircle(String number, bool active) => Container(
    width: Get.width / 13,
    height: Get.width / 13,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: active ? const Color(0xffF78520) : const Color(0xffFAF7F6),
      shape: BoxShape.circle,
    ),
    child: Text(
      number,
      style: GoogleFonts.poppins(
        color: active ? Colors.white : Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: Get.width / 30,
      ),
    ),
  );
}
