import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/user_model.dart';
import 'user_controller.dart';

class CreateUserController extends GetxController {
  final UserController userController = Get.find<UserController>();
  final _storage = GetStorage();

  // Designation options
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

  var isLoading = false.obs;

  TextEditingController userCodeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController joiningDateController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController ifscCodeController = TextEditingController();
  TextEditingController aadharNumberController = TextEditingController();

  // Selected values
  var selectedDesignation = ''.obs;
  var selectedJoiningDate = DateTime.now().obs;
  var userImagePath = ''.obs;
  var chequebookImagePath = ''.obs;
  var imagePdfPath = ''.obs;

  // Image files
  File? userImageFile;
  File? chequebookImageFile;
  File? imagePdfFile;

  // Store image paths permanently
  final String _userImageKey = 'user_image_path';
  final String _chequebookImageKey = 'chequebook_image_path';

  @override
  void onInit() {
    super.onInit();
    _loadStoredData();
    userCodeController.text = generateUserCode();
  }

  // Load stored data
  void _loadStoredData() {
    userImagePath.value = _storage.read(_userImageKey) ?? '';
    chequebookImagePath.value = _storage.read(_chequebookImageKey) ?? '';
  }

  // Save image paths permanently
  void _saveImagePaths() {
    _storage.write(_userImageKey, userImagePath.value);
    _storage.write(_chequebookImageKey, chequebookImagePath.value);
  }

  // Validation methods
  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    if (userController.isEmailExists(value)) {
      return 'Email already exists';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Contact number is required';
    }
    if (value.length != 10) {
      return 'Contact number must be 10 digits';
    }
    return null;
  }

  String? validateAadhar(String? value) {
    if (value == null || value.isEmpty) {
      return 'Aadhar number is required';
    }
    if (value.length != 12) {
      return 'Aadhar number must be 12 digits';
    }
    return null;
  }

  // Check if all required fields are filled
  bool get isFormValid {
    return nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        contactController.text.isNotEmpty &&
        selectedDesignation.value.isNotEmpty &&
        addressController.text.isNotEmpty &&
        joiningDateController.text.isNotEmpty &&
        salaryController.text.isNotEmpty &&
        bankNameController.text.isNotEmpty &&
        accountNumberController.text.isNotEmpty &&
        ifscCodeController.text.isNotEmpty &&
        aadharNumberController.text.isNotEmpty;
  }

  // Generate user code
  String generateUserCode() {
    final count = userController.totalUsersCount + 1;
    return 'EMP${count.toString().padLeft(3, '0')}';
  }

  // Select joining date
  Future<void> selectJoiningDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedJoiningDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedJoiningDate.value) {
      selectedJoiningDate.value = picked;
      joiningDateController.text =
          "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
    }
  }

  // Set user image with permanent storage
  void setUserImage(String path) {
    userImagePath.value = path;
    userImageFile = File(path);
    _saveImagePaths();
  }

  void imagePdf(String path) {
    imagePdfPath.value = path;
    imagePdfFile = File(path);
  }

  // Set chequebook image with permanent storage
  void setChequebookImage(String path) {
    chequebookImagePath.value = path;
    chequebookImageFile = File(path);
    _saveImagePaths();
  }

  // Submit form
  Future<void> submitForm() async {
    if (!isFormValid) {
      Get.snackbar(
        'Error',
        'Please fill all required fields',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (validateEmail(emailController.text) != null ||
        validatePhone(contactController.text) != null ||
        validateAadhar(aadharNumberController.text) != null) {
      Get.snackbar(
        'Error',
        'Please correct the validation errors',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      // In your submitForm method, update the newUser creation:
      final newUser = UserModel(
        userCode: userCodeController.text.isEmpty
            ? generateUserCode()
            : userCodeController.text,
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        contact: contactController.text,
        designation: selectedDesignation.value,
        address: addressController.text,
        joiningDate: joiningDateController.text,
        salary: salaryController.text,
        bankName: bankNameController.text,
        accountNumber: accountNumberController.text,
        ifscCode: ifscCodeController.text,
        aadharNumber: aadharNumberController.text,
        userImage: userImagePath.value,
        chequebookImage: chequebookImagePath.value,
        createdAt: DateTime.now(),
        isActive: true, // Set as active by default
      );
      userController.addUser(newUser);

      Get.snackbar(
        'Success',
        'User created successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      clearForm();
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create user: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Clear form
  void clearForm() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    contactController.clear();
    addressController.clear();
    joiningDateController.clear();
    salaryController.clear();
    bankNameController.clear();
    accountNumberController.clear();
    ifscCodeController.clear();
    aadharNumberController.clear();
    selectedDesignation.value = '';
    userImagePath.value = '';
    chequebookImagePath.value = '';
    userImageFile = null;
    chequebookImageFile = null;

    userCodeController.text = generateUserCode();
    _storage.remove(_userImageKey);
    _storage.remove(_chequebookImageKey);
  }

  @override
  void onClose() {
    userCodeController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    contactController.dispose();
    addressController.dispose();
    joiningDateController.dispose();
    salaryController.dispose();
    bankNameController.dispose();
    accountNumberController.dispose();
    ifscCodeController.dispose();
    aadharNumberController.dispose();
    super.onClose();
  }
}
