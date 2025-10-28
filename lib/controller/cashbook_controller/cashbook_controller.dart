import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/cashbook_model/cashbook_model.dart';

class CashbookController extends GetxController {
  var entries = <CashbookEntry>[].obs;
  var filteredEntries = <CashbookEntry>[].obs;
  var searchController = TextEditingController();

  // 🔹 Reactive filters
  var searchQuery = ''.obs;
  var selectedType = 'All'.obs;
  var selectedStatus = 'All'.obs;
  var fromDate = ''.obs;
  var toDate = ''.obs;
  bool _isLoaded = false;

  // 🔹 Fetch entries from API
  Future<void> fetchCashbookEntries() async {
    final response = await http.get(
      Uri.parse(
        'https://harbhole.eihlims.com/Api/cashbook_entries_api.php?action=list',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final items = data['items'] as List;
      entries.value = items.map((e) => CashbookEntry.fromJson(e)).toList();
      filteredEntries.assignAll(entries); // initially show all
      print("BODY : ${response.body}");
    } else {
      Get.snackbar('Error', 'Failed to load cashbook entries');
    }
  }

  // 🔹 Search filter
  void searchEntries(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  @override
  void onInit() {
    super.onInit();
    if (!_isLoaded) {
      fetchCashbookEntries();
      _isLoaded = true;
    }
  }

  void clearFilters() {
    selectedType.value = "All";
    selectedStatus.value = "All";
    fromDate.value = "";
    toDate.value = "";
    searchQuery.value = "";

    // Refresh displayed list
    filteredEntries.assignAll(entries);
  }

  // 🔹 Apply all filters (search + type + date)
  void applyFilters() {
    var filtered = entries.where((entry) {
      bool matchesSearch =
          searchQuery.value.isEmpty ||
          entry.referenceNo.toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          ) ||
          entry.description.toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          );

      bool matchesType =
          selectedType.value == 'All' ||
          entry.entryType.toLowerCase() == selectedType.value.toLowerCase();

      bool matchesDate = true;
      if (fromDate.value.isNotEmpty && toDate.value.isNotEmpty) {
        try {
          DateTime entryDate = DateTime.parse(entry.entryDate);
          DateTime start = DateTime.parse(fromDate.value);
          DateTime end = DateTime.parse(toDate.value);
          matchesDate =
              entryDate.isAfter(start.subtract(const Duration(days: 1))) &&
              entryDate.isBefore(end.add(const Duration(days: 1)));
        } catch (e) {
          matchesDate = true; // fallback if invalid date format
        }
      }

      return matchesSearch && matchesType && matchesDate;
    }).toList();

    filteredEntries.assignAll(filtered);
  }
}
