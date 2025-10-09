import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../routes/routes.dart';
// Note: We will replace CustomTextField with a custom widget for display
// import '../../../component/textfield.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  Widget _buildDetailWithIcon({
    required String image,
    required String label,
    required String value,
    required double screenWidth,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: Get.height / 80),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon (fixed width)
          Container(
            width: screenWidth / 12,
            height: screenWidth / 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffFFF7ED),
            ),
            child: Padding(
              padding: EdgeInsets.all(screenWidth / 50),
              child: Image(image: AssetImage(image)),
            ),
          ),
          SizedBox(width: screenWidth / 40),

          // Label and Value Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth / 30,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade600,
                    height: 1.2,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth / 28,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailWithoutIcon({
    required String label,
    required String value,
    required double screenWidth,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: Get.height / 80),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: GoogleFonts.poppins(
              fontSize: screenWidth / 25,
              fontWeight: FontWeight.w600,
              height: 1.2,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: screenWidth / 30,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _orderItem(String title, String value, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: screenWidth / 26,
              color: Colors.black,
              fontWeight: FontWeight.w500, // Adjusted weight to match image
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: screenWidth / 26,
              fontWeight: FontWeight.w500,
              color: const Color(0xff5D686E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _subTotal(String title, String value, double screenWidth) {
    final bool isTotal = title.contains('Total');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: screenWidth / 26,
              color: Colors.black,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: screenWidth / 26,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
              color: const Color(0xff5D686E),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = Get.width;
    final screenHeight = Get.height;

    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [
          // --- Custom App Bar ---
          Container(
            padding: EdgeInsets.only(
              left: screenWidth / 30,
              right: screenWidth / 30,
              top: screenHeight / 20, // Padding for status bar
              bottom: screenHeight / 100,
            ),
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xffF78520)),
                  onPressed: () => Get.back(),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(minWidth: screenWidth / 15),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Invoice',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth / 18,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth / 15),
              ],
            ),
          ),

          // --- End Custom App Bar ---
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(screenWidth / 30),

              child: Container(
                padding: EdgeInsets.all(screenWidth / 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05), // Lighter shadow
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ===== DATE AND INVOICE NO =====
                    Text(
                      "Date: 12 Sep, 2025 11:00 AM",
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth / 26, // Smaller font
                        fontWeight: FontWeight.w600, // Bolder
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: screenHeight / 200),
                    Text(
                      "Bill No: B2B202500002",
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth / 26,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: screenHeight / 40),

                    // ===== FROM SECTION =====
                    Text(
                      "From",
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth / 19,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xffF78520),
                      ),
                    ),
                    SizedBox(height: screenHeight / 60),

                    // **REPLACED CustomTextFields with _buildDetailWithIcon**
                    _buildDetailWithIcon(
                      image: "asset/icons/company_name.png",
                      label: "Company Name",
                      value: "Om Har Bhole Farsan",
                      screenWidth: screenWidth,
                    ),
                    _buildDetailWithIcon(
                      image: "asset/icons/location_icon.png",
                      label: "Address",
                      value:
                          "Har Bhole Complex, Sayaji Library Rd, Navsari, Gujarat 396445",
                      screenWidth: screenWidth,
                    ),
                    _buildDetailWithIcon(
                      image: "asset/icons/email_icon.png",
                      label: "Email ID",
                      value: "info@harbholefarsan.com",
                      screenWidth: screenWidth,
                    ),
                    _buildDetailWithIcon(
                      image: "asset/icons/gstin_icon.png",
                      label: "GSTIN",
                      value: "YOURGSTINHERE",
                      screenWidth: screenWidth,
                    ),
                    _buildDetailWithIcon(
                      image: "asset/icons/phone_icon.png",
                      label: "Phone No",
                      value: "9998885550",
                      screenWidth: screenWidth,
                    ),
                    SizedBox(height: screenHeight / 40),
                    Text(
                      "To",
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth / 19,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xffF78520),
                      ),
                    ),
                    SizedBox(height: screenHeight / 60),
                    _buildDetailWithIcon(
                      image: "asset/icons/profile_icon.png",
                      label: "Name",
                      value: "Vishrut",
                      screenWidth: screenWidth,
                    ),
                    _buildDetailWithIcon(
                      image: "asset/icons/email_icon.png",
                      label: "Email",
                      value: "vishrut@gmail.com",
                      screenWidth: screenWidth,
                    ),
                    _buildDetailWithIcon(
                      image: "asset/icons/phone_icon.png",
                      label: "Phone No",
                      value: "9998885550",
                      screenWidth: screenWidth,
                    ),
                    _buildDetailWithIcon(
                      image: "asset/icons/bank_icon.png.",
                      label: "Company",
                      value: "tesr",
                      screenWidth: screenWidth,
                    ),
                    _buildDetailWithIcon(
                      image: "asset/icons/location_icon.png",
                      label: "GSTIN:",
                      value: "",
                      screenWidth: screenWidth,
                    ),
                    SizedBox(height: screenHeight / 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order Items",
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth / 19,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xffF78520),
                          ),
                        ),
                        Text(
                          "Edit",
                          style: GoogleFonts.poppins(
                            color: const Color(0xffF78520),
                            fontWeight: FontWeight.w500,
                            fontSize: screenWidth / 30, // Adjusted font size
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight / 80),

                    _orderItem('Product', 'Farani Petis', screenWidth),
                    _orderItem('Price', '₹200', screenWidth),
                    _orderItem('Varients', '-', screenWidth),
                    _orderItem('QTY', '1', screenWidth),
                    const Divider(),
                    _orderItem('Product', 'Mohanthal', screenWidth),
                    _orderItem('Price', '₹100', screenWidth),
                    _orderItem('Varients', '500gm', screenWidth),
                    _orderItem('QTY', '1', screenWidth),
                    const Divider(),

                    // Total rows use _subTotal
                    _subTotal('Subtotal', '₹300', screenWidth),
                    _subTotal('Tax Rate(12.00%)', '₹36', screenWidth),
                    _subTotal('Total(Incl.Tax)', '₹336', screenWidth),

                    SizedBox(height: screenHeight / 40),

                    // ===== BANK DETAILS =====
                    Text(
                      "Bank Details",
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth / 19,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xffF78520),
                      ),
                    ),
                    SizedBox(height: screenHeight / 60),

                    _buildDetailWithoutIcon(
                      label: "Account Name",
                      value: "Om Har Bhole Farsan",
                      screenWidth: screenWidth,
                    ),
                    _buildDetailWithoutIcon(
                      label: "Account No",
                      value: "0000000",
                      screenWidth: screenWidth,
                    ),
                    _buildDetailWithoutIcon(
                      label: "IFSC",
                      value: "BANK0000000",
                      screenWidth: screenWidth,
                    ),
                    _buildDetailWithoutIcon(
                      label: "Bank",
                      value: "Your Bank Name, Your Branch",
                      screenWidth: screenWidth,
                    ),
                    _buildDetailWithoutIcon(
                      label: "UPI ID",
                      value: "yourupi@bank",
                      screenWidth: screenWidth,
                    ),

                    SizedBox(height: screenHeight / 30),
                    SizedBox(
                      height: Get.height / 18,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.createNewb2bOrder);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffF78520),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Create Manual Order',
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
            ),
          ),
          SizedBox(height: screenHeight / 30), // Increased bottom spacing
        ],
      ),
    );
  }
}
