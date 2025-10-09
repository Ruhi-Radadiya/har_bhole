// products_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../routes/routes.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color mainOrange = Color(0xffF78520);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                            'Products',
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
                            'Manage all Products',
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
                        Get.toNamed(Routes.createProduct);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffF78520),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Add Products',
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
              padding: EdgeInsets.only(
                left: Get.width / 18,
                right: Get.width / 18,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height / 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'All Products',
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
                    padding: EdgeInsets.all(Get.width / 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Search Field
                        Container(
                          height: Get.height / 20,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: TextField(
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              hintText: 'Search Products',
                              hintStyle: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: Get.width / 26,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey.shade500,
                                size: 20,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: Get.height / 80,
                                horizontal: Get.width / 40,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height / 80),
                        const Divider(height: 1, color: Color(0xffF2F3F5)),
                        _buildCategoryTile(
                          title: 'Rajvadi Peda',
                          subtitle: '500g',
                          status: 'Active',
                          statusColor: Color(0xffDCE1D7),
                          statusTextColor: Color(0xff4E6B37),
                        ),
                        const Divider(height: 1, color: Color(0xffF2F3F5)),
                        _buildCategoryTile(
                          title: 'White Farani Chevdo',
                          subtitle: '1KG',
                          status: 'INActive',
                          statusColor: Color(0xffEFCFD2),
                          statusTextColor: Color(0xffAD111E),
                        ),
                        // Products List
                        // Obx(
                        //   () => Column(
                        //     children: productController.filteredProducts
                        //         .map(
                        //           (product) => Column(
                        //             children: [
                        //               _buildProductTile(product: product),
                        //               const Divider(
                        //                 height: 1,
                        //                 color: Color(0xffF2F3F5),
                        //               ),
                        //             ],
                        //           ),
                        //         )
                        //         .toList(),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height / 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTile({
    required String title,
    required String subtitle,
    required String status,
    required Color statusColor,
    required Color statusTextColor,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height / 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: Get.width / 8,
                height: Get.width / 8,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: AssetImage('asset/images/about/jalebi.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: Get.width / 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 10.5,
                        color: Colors.grey.shade600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
                  color: statusColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: statusTextColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height / 200),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.productDetails);
                },
                child: Text(
                  'View Details',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 10,
                      color: Color(0xff2A86D1),
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

  // Widget _buildProductTile({required Product product}) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: Get.height / 80),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Row(
  //           children: [
  //             Container(
  //               width: Get.width / 8,
  //               height: Get.width / 8,
  //               decoration: BoxDecoration(
  //                 color: Colors.grey.shade200,
  //                 borderRadius: BorderRadius.circular(15.0),
  //                 image: DecorationImage(
  //                   image: AssetImage(product.imageUrl),
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //             ),
  //             SizedBox(width: Get.width / 30),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   product.productName,
  //                   style: GoogleFonts.poppins(
  //                     textStyle: TextStyle(
  //                       fontSize: Get.width / 24,
  //                       fontWeight: FontWeight.w600,
  //                       color: Colors.black,
  //                     ),
  //                   ),
  //                 ),
  //                 Text(
  //                   '${product.netWeight}g',
  //                   style: GoogleFonts.poppins(
  //                     textStyle: TextStyle(
  //                       fontSize: Get.width / 34.5,
  //                       color: Colors.grey.shade600,
  //                       overflow: TextOverflow.ellipsis,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.end,
  //           children: [
  //             Container(
  //               padding: const EdgeInsets.symmetric(
  //                 horizontal: 12,
  //                 vertical: 4,
  //               ),
  //               decoration: BoxDecoration(
  //                 color: productController.getStatusBgColor(
  //                   product.isActive ? 'Active' : 'INActive',
  //                 ),
  //                 borderRadius: BorderRadius.circular(15.0),
  //               ),
  //               child: Text(
  //                 product.isActive ? 'Active' : 'INActive',
  //                 style: GoogleFonts.poppins(
  //                   textStyle: TextStyle(
  //                     fontSize: Get.width / 36,
  //                     fontWeight: FontWeight.bold,
  //                     color: productController.getStatusColor(
  //                       product.isActive ? 'Active' : 'INActive',
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(height: Get.height / 200),
  //             GestureDetector(
  //               onTap: () {
  //                 productController.setSelectedProduct(product);
  //                 Get.toNamed(Routes.productDetails);
  //               },
  //               child: Text(
  //                 'View Details',
  //                 style: GoogleFonts.poppins(
  //                   textStyle: TextStyle(
  //                     fontSize: Get.width / 36,
  //                     color: Color(0xff2A86D1),
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
