import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/routes/routes.dart';

class GeneralVouchersScreen extends StatelessWidget {
  const GeneralVouchersScreen({super.key});

  // Helper for the custom voucher list tile
  Widget _buildVoucherTile({
    required String reference,
    required String amount,
    required String status,
    required Color statusColor,
  }) {
    const Color mainOrange = Color(0xffF78520);

    return Padding(
      // Use Get.height/XX for vertical padding
      padding: EdgeInsets.symmetric(vertical: Get.height / 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reference,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    amount,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
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
              // Status Tag (Approved/Pending)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
              ),
              // View Details
              SizedBox(height: Get.height / 200),
              Text(
                'View Details',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    color: mainOrange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper for custom dropdown
  Widget _buildCustomDropdown(String hint) {
    return Container(
      width: Get.width / 5, // Width adjusted for 4 items in a row
      height: Get.height / 22,
      padding: EdgeInsets.symmetric(horizontal: Get.width / 50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            hint,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 9, // Smaller font for filters
                color: Colors.grey.shade600,
              ),
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.grey),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color mainOrange = Color(0xffF78520);
    const Color approvedGreen = Color(0xff4CAF50);
    const Color pendingRed = Color(0xffFF3B30);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
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
                          'General Vouchers',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height / 200),
                        Text(
                          'Manage all General Vouchers',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 13,
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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffF78520),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Voucher',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 16,
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
          Expanded(
            child: Container(
              color: Colors.grey.shade200,
              padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
              child: Column(
                children: [
                  SizedBox(height: Get.height / 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'General Vouchers',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          /* View All Logic */
                        },
                        child: Text(
                          'View All',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: mainOrange,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height / 50),
                  Container(
                    padding: EdgeInsets.all(Get.width / 28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
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
                            decoration: InputDecoration(
                              hintText: 'Reference / Description',
                              hintStyle: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 14,
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
                        SizedBox(height: Get.height / 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildFilterField(
                              label: "Type",
                              child: _buildFilterDropdown(label: "All"),
                            ),
                            _buildFilterField(
                              label: "Status",
                              child: _buildFilterDropdown(label: "All"),
                            ),
                            _buildFilterField(
                              label: "From",
                              child: _buildDateFilter(date: "25/09/2024"),
                            ),
                            _buildFilterField(
                              label: "To",
                              child: _buildDateFilter(date: "25/09/2024"),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height / 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "OHB/PAY/0002",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "₹6,010.00",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xffDCE1D7),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    "Approved",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xff4E6B37),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.viewVouchers);
                                  },
                                  child: Text(
                                    "View Details",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height / 50),
                        const Divider(height: 1, color: Colors.grey),
                        SizedBox(height: Get.height / 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "OHB/PAY/0002",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "₹6,010.00",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xffDCE1D7),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    "Approved",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xff4E6B37),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    "View Details",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height / 50),
                      ],
                    ),
                  ),
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
      width: Get.width / 4.5,
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
              textStyle: TextStyle(fontSize: 9, color: Colors.grey.shade700),
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildDateFilter({required String date}) {
    return Container(
      width: Get.width / 4.5,
      height: Get.height / 22,
      padding: EdgeInsets.symmetric(horizontal: Get.width / 50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        date,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(fontSize: 9, color: Colors.grey.shade700),
        ),
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
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 6),
          child,
        ],
      ),
    );
  }
}
