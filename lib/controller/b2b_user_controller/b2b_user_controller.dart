import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/b2b_user/b2b_user_model.dart';

class B2BUserController extends GetxController {
  static B2BUserController get instance => Get.find();

  var users = <B2BUser>[].obs; // full list from API
  var filteredUsers = <B2BUser>[].obs; // filtered for search
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
        Uri.parse(
          'https://harbhole.eihlims.com/Api/b2busers_api.php?action=list',
        ),
      ); // replace with actual API
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final items = data['items'] as List;
        users.value = items.map((e) => B2BUser.fromJson(e)).toList();
        filteredUsers.value = users; // initially all users
      } else {
        Get.snackbar("Error", "Failed to fetch users");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Search function for the text field
  void searchUser(String query) {
    if (query.isEmpty) {
      filteredUsers.value = users;
    } else {
      filteredUsers.value = users
          .where((u) => u.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
