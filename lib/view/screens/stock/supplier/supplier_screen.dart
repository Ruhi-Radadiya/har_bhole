import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/main.dart';
import 'package:har_bhole/view/screens/stock/supplier/view_supplier_screen.dart';

import '../../../../controller/supplier_controller/supplier_controller.dart';
import '../../../../model/supplier_model/supplier_model.dart';
import '../../../../routes/routes.dart';
import '../../../component/textfield.dart';

class SupplierScreen extends StatefulWidget {
  const SupplierScreen({super.key});

  @override
  State<SupplierScreen> createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {
  @override
  void initState() {
    super.initState();
    if (!supplierController.isInitialized) {
      supplierController.fetchSuppliers();
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color mainOrange = Color(0xffF78520);
    if (!supplierController.isInitialized) {
      supplierController.fetchSuppliers();
    }
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
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
                                child: Image.asset(
                                  'asset/icons/users_icon.png',
                                ),
                              ),
                            ),
                            SizedBox(width: Get.width / 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Suppliers',
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
                                  'Manage all Suppliers',
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
                              // Clear old form data before navigating
                              addSupplierController.clearAllFields();

                              // Navigate to Add Supplier screen (not edit mode)
                              Get.toNamed(
                                Routes.addNewSupplier,
                                arguments: {"isEdit": false},
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
                              'Add New Supplier',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'All Suppliers',
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
                                hint: "Search Supplier",
                                icon: Icons.search,
                                onChanged: (value) {
                                  Future.delayed(
                                    Duration(milliseconds: 50),
                                    () {
                                      if (Get.isRegistered<
                                        SupplierController
                                      >()) {
                                        supplierController.searchSupplier(
                                          value,
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                              SizedBox(height: Get.height / 80),
                              const Divider(
                                height: 1,
                                color: Color(0xffF2F3F5),
                              ),
                              Obx(() {
                                if (supplierController.isLoading.value) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Color(0xffF78520),
                                    ),
                                  );
                                }
                                if (supplierController
                                    .errorMessage
                                    .isNotEmpty) {
                                  return Center(
                                    child: Text(
                                      supplierController.errorMessage.value,
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  );
                                }
                                if (supplierController
                                    .filteredSupplier
                                    .isEmpty) {
                                  return const Center(
                                    child: Text('No Suppliers found'),
                                  );
                                }
                                return Column(
                                  children: List.generate(
                                    supplierController.filteredSupplier.length,
                                    (index) {
                                      final item = supplierController
                                          .filteredSupplier[index];
                                      return Column(
                                        children: [
                                          _buildCategoryTile(item),
                                          if (index !=
                                              supplierController
                                                      .filteredSupplier
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
      },
    );
  }

  Widget _buildCategoryTile(Supplier item) {
    // double qty = double.tryParse(item. ?? "0") ?? 0;
    // bool inStock = qty > 0;

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
                        item.supplierName,
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
                        item.notes,
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
                  color: (item.status.trim().toLowerCase() == 'active')
                      ? const Color(0xffDCE1D7) // Light green
                      : const Color(0xffEFCFD2), // Light red
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text(
                  (item.status.trim().toLowerCase() == 'active')
                      ? "Active"
                      : "Inactive",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: Get.width / 36,
                      fontWeight: FontWeight.bold,
                      color: (item.status.trim().toLowerCase() == 'active')
                          ? const Color(0xff4E6B37) // Dark green
                          : const Color(0xffAD111E), // Dark red
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height / 200),
              GestureDetector(
                onTap: () async {
                  FocusScope.of(context).unfocus();

                  // 🟠 Pause reactivity before navigating
                  supplierController.isActive.value = false;

                  await Get.to(() => ViewSupplierScreen(), arguments: item);

                  // 🟢 Resume reactivity after coming back
                  Future.delayed(const Duration(milliseconds: 200), () {
                    if (Get.isRegistered<SupplierController>()) {
                      supplierController.isActive.value = true;
                      supplierController.filteredSupplier
                          .refresh(); // safe refresh
                    }
                  });
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
