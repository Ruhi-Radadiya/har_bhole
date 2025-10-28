import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/main.dart';

import '../../../../routes/routes.dart';
import '../../../component/textfield.dart';

class CustomerDetailScreen extends StatelessWidget {
  const CustomerDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (customerDetailController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xffF78520)),
          );
        }

        if (customerDetailController.customerList.isEmpty) {
          return const Center(child: Text("No customers found"));
        }

        return Column(
          children: [
            SizedBox(height: Get.height / 30),
            _buildTopBar(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(Get.width / 30),
                itemCount: customerDetailController.customerList.length,
                itemBuilder: (context, index) {
                  final customer = customerDetailController.customerList[index];

                  return Container(
                    margin: EdgeInsets.only(bottom: Get.height / 40),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Customer Details',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: Get.width / 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height / 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomTextField(
                                hint: "Search",
                                icon: Icons.search,
                              ),
                            ),
                            SizedBox(width: Get.width / 90),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Show',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontSize: Get.width / 30,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '10',
                                            style: TextStyle(
                                              color: Color(0xffF78520),
                                              fontWeight: FontWeight.bold,
                                              fontSize: Get.width / 36,
                                            ),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            color: Color(0xffF78520),
                                            size: 14,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
                                    'Apply',
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
                        CustomTextField(
                          label: 'ID',
                          hint: customer.id,
                          isReadOnly: true,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Name',
                          hint: customer.name,
                          isReadOnly: true,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Email',
                          hint: customer.email,
                          isReadOnly: true,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Mobile',
                          hint: customer.mobile,
                          isReadOnly: true,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'City',
                          hint: customer.city,
                          isReadOnly: true,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Registered',
                          hint: customer.createdAt,
                          isReadOnly: true,
                        ),

                        SizedBox(height: Get.height / 50),

                        /// View button
                        SizedBox(
                          width: double.infinity,
                          height: Get.height / 18,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF78520),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Get.toNamed(
                                Routes.viewCustomerDetailScreen,
                                arguments: customer,
                              );
                            },
                            child: Text(
                              "View",
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
                  );
                },
              ),
            ),
            SizedBox(height: Get.height / 20),
          ],
        );
      }),
    );
  }

  Widget _buildTopBar() {
    return Container(
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
        ],
      ),
    );
  }
}
