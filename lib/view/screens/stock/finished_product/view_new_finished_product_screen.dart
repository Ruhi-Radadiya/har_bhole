import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../component/textfield.dart';

class ViewNewFinishedProductScreen extends StatelessWidget {
  ViewNewFinishedProductScreen({super.key});

  final List<Map<String, String>> infoData = [
    {'count': '10', 'label': 'Total item'},
    {'count': '10', 'label': 'In Stock'},
    {'count': '00', 'label': 'Out of Stock'},
  ];
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
                  _buildInfoGrid(infoData),
                  SizedBox(height: Get.height / 30),

                  Container(
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
                        // Edit/Cancel Buttons Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Finished Goods',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildFilterField(
                              label: "Category",
                              child: _buildFilterDropdown(
                                label: "All categories",
                              ),
                            ),
                            _buildFilterField(
                              label: "Status",
                              child: _buildFilterDropdown(label: "All Statue"),
                            ),
                            _buildFilterField(
                              label: "Stock Status",
                              child: _buildFilterDropdown(label: "All Stock"),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height / 50),
                        CustomTextField(
                          label: 'Code',
                          hint: 'RMD01',
                          isReadOnly: true,
                          controller: TextEditingController(text: 'RMD01'),
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Name',
                          hint: 'Maida',
                          isReadOnly: true,
                          controller: TextEditingController(text: 'Maida'),
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Category',
                          hint: 'Namkeen',
                          isReadOnly: true,
                        ),
                        SizedBox(height: Get.height / 60),
                        _buildCurrentStockField(),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Cost/Unit',
                          hint: '210.00',
                          isReadOnly: true,
                          controller: TextEditingController(text: '210.00'),
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Unit',
                          hint: 'Pack',
                          isReadOnly: true,
                          controller: TextEditingController(text: '₹ 30.00'),
                        ),
                        _buildPagination(),
                        SizedBox(height: Get.height / 100),
                        SizedBox(
                          width: double.infinity,
                          height: Get.height / 18,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffF78520),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Add Movement",
                              style: GoogleFonts.poppins(
                                fontSize: Get.width / 22.5,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height / 20),
                ],
              ),
            ),
          ),
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

  Widget _buildCurrentStockField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Current Stock',
          style: TextStyle(
            fontSize: Get.width / 26,
            fontWeight: FontWeight.w500,
            color: Color(0xff000000),
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
                '100',
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
          Container(
            width: Get.width / 13,
            height: Get.width / 13,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffFAF7F6),
            ),
            child: const Icon(
              Icons.keyboard_double_arrow_left,
              size: 19,
              color: Colors.black,
            ),
          ),
          SizedBox(width: Get.width / 40),
          Container(
            width: Get.width / 13,
            height: Get.width / 13,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xffF78520),
              shape: BoxShape.circle,
            ),
            child: Text(
              '1',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: Get.width / 30,
              ),
            ),
          ),
          SizedBox(width: Get.width / 40),
          Container(
            width: Get.width / 13,
            height: Get.width / 13,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xffF78520),
              shape: BoxShape.circle,
            ),
            child: Text(
              '2',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: Get.width / 30,
              ),
            ),
          ),
          SizedBox(width: Get.width / 40),
          Container(
            width: Get.width / 13,
            height: Get.width / 13,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffFAF7F6),
            ),
            child: const Icon(
              Icons.keyboard_double_arrow_right,
              size: 19,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
