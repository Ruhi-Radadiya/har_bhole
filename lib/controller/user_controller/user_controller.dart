import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/user_model.dart';

class UserController extends GetxController {
  final RxList<UserModel> _users = <UserModel>[].obs;
  final _storage = GetStorage();
  final String _storageKey = 'users_data';

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

  List<UserModel> get users => _users;

  int get totalUsersCount => _users.length;

  // Add these computed properties for dashboard
  int get activeUsersCount => _users.where((user) => user.isActive).length;

  int get inactiveUsersCount => _users.where((user) => !user.isActive).length;

  int get newUsersThisMonth {
    final now = DateTime.now();
    final currentMonth = DateTime(now.year, now.month);
    return _users.where((user) {
      final userMonth = DateTime(user.createdAt.year, user.createdAt.month);
      return userMonth == currentMonth;
    }).length;
  }

  // Get recent users (last 5 users)
  List<UserModel> get recentUsers {
    final sortedUsers = List<UserModel>.from(_users)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sortedUsers.take(5).toList();
  }

  @override
  void onInit() {
    super.onInit();
    _loadUsersFromStorage();
  }

  // Load users from permanent storage
  void _loadUsersFromStorage() {
    try {
      final storedData = _storage.read(_storageKey);
      if (storedData != null && storedData is String) {
        final List<dynamic> jsonList = json.decode(storedData);
        _users.assignAll(
          jsonList.map((json) => UserModel.fromJson(json)).toList(),
        );
      }
    } catch (e) {
      print('Error loading users from storage: $e');
      _users.clear();
    }
  }

  // Save users to permanent storage
  void _saveUsersToStorage() {
    try {
      final jsonList = _users.map((user) => user.toJson()).toList();
      final jsonString = json.encode(jsonList);
      _storage.write(_storageKey, jsonString);
    } catch (e) {
      print('Error saving users to storage: $e');
    }
  }

  // Add user with permanent storage
  void addUser(UserModel user) {
    _users.add(user);
    _saveUsersToStorage();
    update();
  }

  // Update user with permanent storage
  void updateUser(int index, UserModel updatedUser) {
    if (index >= 0 && index < _users.length) {
      _users[index] = updatedUser;
      _saveUsersToStorage();
      update();
    }
  }

  // Delete user with permanent storage
  void deleteUser(int index) {
    if (index >= 0 && index < _users.length) {
      _users.removeAt(index);
      _saveUsersToStorage();
      update();
    }
  }

  // Clear all users with permanent storage
  void clearAllUsers() {
    _users.clear();
    _storage.remove(_storageKey);
    update();
  }

  // Get user by index
  UserModel getUser(int index) {
    return _users[index];
  }

  // Find user by user code
  UserModel? findUserByCode(String userCode) {
    try {
      return _users.firstWhere((user) => user.userCode == userCode);
    } catch (e) {
      return null;
    }
  }

  // Find user by email
  UserModel? findUserByEmail(String email) {
    try {
      return _users.firstWhere((user) => user.email == email);
    } catch (e) {
      return null;
    }
  }

  // Check if email already exists
  bool isEmailExists(String email) {
    return _users.any((user) => user.email == email);
  }

  // Toggle user active status
  void toggleUserStatus(int index) {
    if (index >= 0 && index < _users.length) {
      final user = _users[index];
      final updatedUser = UserModel(
        userCode: user.userCode,
        name: user.name,
        email: user.email,
        password: user.password,
        contact: user.contact,
        designation: user.designation,
        address: user.address,
        joiningDate: user.joiningDate,
        salary: user.salary,
        bankName: user.bankName,
        accountNumber: user.accountNumber,
        ifscCode: user.ifscCode,
        aadharNumber: user.aadharNumber,
        userImage: user.userImage,
        chequebookImage: user.chequebookImage,
        createdAt: user.createdAt,
        isActive: !user.isActive, // Toggle status
      );
      updateUser(index, updatedUser);
    }
  }
}
