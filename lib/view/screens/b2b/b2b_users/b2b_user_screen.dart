import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/routes/routes.dart';

import '../../../../main.dart';
import '../../../component/textfield.dart';

class B2BUserScreen extends StatelessWidget {
  B2BUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color mainOrange = Color(0xffF78520);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // -------------------- HEADER --------------------
            Container(
              padding: EdgeInsets.only(
                top: Get.height / 25,
                left: Get.width / 25,
                right: Get.width / 25,
                bottom: Get.height / 50,
              ),
              decoration: BoxDecoration(
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
                      Text(
                        'B2B Users',
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
                  SizedBox(
                    height: Get.height / 18,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Routes.createNewb2bUser);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Add B2B Users',
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

            SizedBox(height: Get.height / 50),

            // -------------------- SEARCH --------------------
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Get.width / 40),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CustomTextField(
                        icon: Icons.search,
                        hint: "Search by Name...",
                        onChanged: (value) =>
                            b2bUserController.searchUser(value),
                      ),
                    ),
                  ),
                  SizedBox(width: Get.width / 40),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width / 40,
                      vertical: Get.height / 200,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "All Status",
                          style: GoogleFonts.poppins(
                            fontSize: Get.width / 26,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height / 50),
            // -------------------- USER LIST --------------------
            Expanded(
              child: Obx(() {
                if (b2bUserController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (b2bUserController.filteredUsers.isEmpty) {
                  return const Center(child: Text("No users found"));
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                  itemCount: b2bUserController.filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = b2bUserController.filteredUsers[index];
                    return _buildUserCard(
                      name: user.name,
                      email: user.email,
                      mobile: user.phone,
                      address: user.address ?? "No address", // provide address
                      status: user.status,
                      statusColor: user.status.toLowerCase() == "active"
                          ? const Color(0xff4E6B37)
                          : const Color(0xffAD111E),
                      statusBgColour: user.status.toLowerCase() == "active"
                          ? const Color(0xffDCE1D7)
                          : const Color(0xffEFCFD2),
                      userCode: user.id,
                      onEdit: () {
                        // Navigate to edit page or open edit dialog
                        // Get.to(() => EditUserScreen(), arguments: user);
                      },
                      onDelete: () {
                        Get.defaultDialog(
                          title: "Delete User",
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
                              "Are you sure you want to delete ${user.name}?",
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
                            await createB2bUserController.deleteB2BUser(
                              user.id,
                            );
                            if (Get.isDialogOpen ?? false) Get.back();
                          },
                          onCancel: () {
                            if (Get.isDialogOpen ?? false) Get.back();
                          },
                        );
                      },
                    );
                  },
                );
              }),
            ),
            SizedBox(height: Get.height / 20),
          ],
        ),
      ),
    );
  }

  // -------------------- USER TILE --------------------
  Widget _buildUserCard({
    required String name,
    required String email,
    required String mobile,
    required String address,
    required String status,
    required Color statusColor,
    required Color statusBgColour,
    required String userCode,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Get.height / 80,
        // horizontal: Get.width / 25,
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.8),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(Get.width / 25),
          child: Stack(
            children: [
              // Main content
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height / 60,
                  ), // Space for top-right status
                  // Name
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: Get.width / 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: Get.height / 200),

                  // Email
                  Text(
                    email,
                    style: GoogleFonts.poppins(
                      fontSize: Get.width / 28,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: Get.height / 300),

                  // Mobile
                  Text(
                    mobile,
                    style: GoogleFonts.poppins(
                      fontSize: Get.width / 28,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: Get.height / 300),

                  // Address
                  Text(
                    address,
                    style: GoogleFonts.poppins(
                      fontSize: Get.width / 28,
                      color: Colors.grey.shade700,
                    ),
                  ),

                  SizedBox(height: Get.height / 40),

                  // Buttons row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Edit button
                      GestureDetector(
                        onTap: onEdit,
                        child: Container(
                          width: Get.width / 12,
                          height: Get.width / 12,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffF78520),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 18,
                            color: Color(0xffF78520),
                          ),
                        ),
                      ),
                      SizedBox(width: Get.width / 30),

                      // Delete button
                      GestureDetector(
                        onTap: onDelete,
                        child: Container(
                          width: Get.width / 12,
                          height: Get.width / 12,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffF78520),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(
                            Icons.delete,
                            size: 18,
                            color: Color(0xffF78520),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Status badge top-right
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width / 30,
                    vertical: Get.height / 300,
                  ),
                  decoration: BoxDecoration(
                    color: statusBgColour,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: GoogleFonts.poppins(
                      fontSize: Get.width / 34,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
