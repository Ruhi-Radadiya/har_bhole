import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/user_model/dashboard_user_model.dart';

class DashboardUsersController extends GetxController {
  static DashboardUsersController get instance => Get.find();

  var allUsers = <DashboardUserModel>[].obs;
  var recentUsers = <DashboardUserModel>[].obs;

  var totalUsersCount = 0.obs;
  var activeUsersCount = 0.obs;
  var inactiveUsersCount = 0.obs;
  var newUsersThisMonth = 0.obs;

  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    isLoading(true);
    try {
      final response = await http.get(
        Uri.parse('https://harbhole.eihlims.com/Api/user_api.php?action=list'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Safely get items, default to empty list
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

  void searchUsers(String query) {
    if (query.isEmpty) {
      recentUsers.value = allUsers.reversed.take(3).toList();
    } else {
      recentUsers.value = allUsers
          .where(
            (u) =>
                u.userName.toLowerCase().contains(query.toLowerCase()) ||
                (u.userEmail ?? '').toLowerCase().contains(
                  query.toLowerCase(),
                ) ||
                (u.userPhone ?? '').contains(query),
          )
          .toList();
    }
  }
}
