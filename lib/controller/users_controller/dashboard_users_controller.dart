import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:har_bhole/model/user_model/dashboard_user_model.dart';
import 'package:http/http.dart' as http;

class DashboardUsersController extends GetxController {
  static DashboardUsersController get instance => Get.find();
  String? editingUserId;

  var allUsers = <DashboardUserModel>[].obs;
  var recentUsers = <DashboardUserModel>[].obs;
  final userImage = Rxn<dynamic>(); // can be File, XFile, or URL
  final chequebookImage = Rxn<dynamic>();
  var totalUsersCount = 0.obs;
  var activeUsersCount = 0.obs;
  var inactiveUsersCount = 0.obs;
  var newUsersThisMonth = 0.obs;
  var selectedDesignation = ''.obs;
  final List<String> designationOptions = [
    'Manager',
    'Supervisor',
    'Employee',
    'Admin',
    'Accountant',
    'Sales Executive',
    'Marketing Manager',
    'HR Manager',
    'IT Support',
    'Operations Manager',
    'Team Lead',
    'Developer',
    'Designer',
    'Analyst',
    'Consultant',
  ];

  var isLoading = true.obs;

  final userCodeController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final contactController = TextEditingController();
  final addressController = TextEditingController();
  final designationController = TextEditingController();
  final joiningDateController = TextEditingController();
  final salaryController = TextEditingController();
  final bankNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final ifscCodeController = TextEditingController();
  final aadharNumberController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  // ---------------- FETCH USERS ----------------
  Future<void> fetchUsers() async {
    isLoading(true);
    try {
      final response = await http.get(
        Uri.parse('https://harbhole.eihlims.com/Api/user_api.php?action=list'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final items = (data['items'] ?? []) as List<dynamic>;

        allUsers.value = items
            .map((e) => DashboardUserModel.fromJson(e))
            .toList();

        recentUsers.value = allUsers.reversed.take(3).toList();

        totalUsersCount.value = allUsers.length;
        activeUsersCount.value = allUsers
            .where((u) => u.userEmail != null)
            .length;
        inactiveUsersCount.value = allUsers
            .where((u) => u.userEmail == null)
            .length;

        newUsersThisMonth.value = allUsers
            .where(
              (u) =>
                  u.joiningDate != null && u.joiningDate!.startsWith('2025-10'),
            )
            .length;
      } else {
        Get.snackbar("Error", "Failed to fetch users");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      log("Error: $e");
    } finally {
      isLoading(false);
    }
  }

  // ---------------- SEARCH USERS ----------------
  void searchUsers(String query) {
    if (query.isEmpty) {
      recentUsers.value = allUsers.reversed.take(3).toList();
    } else {
      final lowerQuery = query.toLowerCase();
      recentUsers.value = allUsers
          .where(
            (u) =>
                (u.userName ?? '').toLowerCase().contains(lowerQuery) ||
                (u.userEmail ?? '').toLowerCase().contains(lowerQuery) ||
                (u.userPhone ?? '').contains(query),
          )
          .toList();
    }
  }

  void fillUserData(DashboardUserModel u) {
    try {
      // Save editing id
      editingUserId = u.userId;

      userCodeController.text = u.userCode ?? '';
      nameController.text = u.userName ?? '';
      emailController.text = u.userEmail ?? '';
      contactController.text = u.userPhone ?? '';
      addressController.text = u.userAddress ?? '';
      joiningDateController.text = u.joiningDate ?? '';
      salaryController.text = u.salary ?? '';
      bankNameController.text = u.bankName ?? '';
      accountNumberController.text = u.accountNumber ?? '';
      ifscCodeController.text = u.ifscCode ?? '';
      aadharNumberController.text = u.aadharNumber ?? '';
      if (u.userImage != null) {
        userImage.value = u.userImage; // can be URL string
      } else {
        userImage.value = null;
      }

      if (u.chequebookImage != null) {
        chequebookImage.value = u.chequebookImage;
      } else {
        chequebookImage.value = null;
      }

      // designation in API is numeric string, but your UI expects readable text.
      // If you want to keep the raw value, assign directly; otherwise map it:
      if (u.designation != null && u.designation!.isNotEmpty) {
        // attempt to map numeric designation index to string in designationOptions
        final idx = int.tryParse(u.designation!);
        if (idx != null && idx >= 0 && idx < designationOptions.length) {
          selectedDesignation.value = designationOptions[idx];
        } else {
          // fallback to raw value
          selectedDesignation.value = u.designation!;
        }
      } else {
        selectedDesignation.value = '';
      }
    } catch (e) {
      log("fillUserData error: $e");
    }
  }

  // --- Clear all form fields for "Add" mode ---
  void clearFields() {
    editingUserId = null;

    userCodeController.clear();
    nameController.clear();
    emailController.clear();
    contactController.clear();
    addressController.clear();
    joiningDateController.clear();
    salaryController.clear();
    bankNameController.clear();
    accountNumberController.clear();
    ifscCodeController.clear();
    aadharNumberController.clear();
    selectedDesignation.value = '';
    userImage.value = null;
    chequebookImage.value = null;
  }

  // --- Update user method updated to use editingUserId if passed empty ---
}
