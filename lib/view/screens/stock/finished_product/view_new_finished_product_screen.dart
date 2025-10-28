import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/main.dart';

import '../../../../model/finished_goods_stock/finished_goods_stock_model.dart';
import '../../../component/textfield.dart';

class ViewNewFinishedProductScreen extends StatelessWidget {
  const ViewNewFinishedProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FinishedGoodsStockModel item =
        Get.arguments; // ✅ Get the passed product

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
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xffF78520)),
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
                        Text(
                          'Finished Goods Details',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: Get.width / 22.5,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xffF78520),
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height / 40),

                        // Product Code
                        CustomTextField(
                          label: 'Product Code',
                          controller: TextEditingController(
                            text: item.productCode ?? '',
                          ),
                          isReadOnly: true,
                          hint: '',
                        ),
                        SizedBox(height: Get.height / 40),

                        // Product Name
                        CustomTextField(
                          label: 'Product Name',
                          controller: TextEditingController(
                            text: item.productName ?? '',
                          ),
                          isReadOnly: true,
                          hint: '',
                        ),
                        SizedBox(height: Get.height / 40),

                        // Category Name
                        CustomTextField(
                          label: 'Category',
                          controller: TextEditingController(
                            text: item.categoryName ?? '',
                          ),
                          isReadOnly: true,
                          hint: '',
                        ),
                        SizedBox(height: Get.height / 40),

                        // Current Stock
                        CustomTextField(
                          label: 'Current Stock',
                          controller: TextEditingController(
                            text: item.currentQuantity ?? '',
                          ),
                          isReadOnly: true,
                          hint: '',
                        ),
                        SizedBox(height: Get.height / 40),

                        // Produced Total Weight
                        CustomTextField(
                          label: 'Produced Total Weight (grams)',
                          controller: TextEditingController(
                            text: item.producedTotalWeightGrams ?? '',
                          ),
                          isReadOnly: true,
                          hint: '',
                        ),
                        SizedBox(height: Get.height / 40),

                        // Unit
                        CustomTextField(
                          label: 'Unit of Measure',
                          controller: TextEditingController(
                            text: item.unitOfMeasure ?? '',
                          ),
                          isReadOnly: true,
                          hint: '',
                        ),

                        SizedBox(height: Get.height / 20),

                        // Edit button
                        SizedBox(
                          height: Get.height / 18,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // TODO: Navigate to edit screen if needed
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF78520),
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

                        // Delete button
                        SizedBox(
                          height: Get.height / 18,
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () async {
                              await Get.defaultDialog(
                                title: "Delete Finished Product",
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
                                    "Are you sure you want to delete this finished product?",
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
                                  if (Get.isDialogOpen ?? false) Get.back();
                                  await finishedGoodsStockController
                                      .deleteFinishedGoodsStock(
                                        item.stockId.toString(),
                                      );
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
                  SizedBox(height: Get.height / 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
