import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/voucher_model/voucher_model.dart';

class VouchersController extends GetxController {
  static VouchersController get instance => Get.find();

  RxList<Voucher> voucherList = <Voucher>[].obs;
  RxList<Voucher> filteredVouchers = <Voucher>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  // 🔹 Filter selections
  RxString selectedType = 'All'.obs;
  RxString selectedStatus = 'All'.obs;
  RxString fromDate = ''.obs;
  RxString toDate = ''.obs;
  RxString searchQuery = ''.obs; // added for resetting search

  final String apiUrl =
      'https://harbhole.eihlims.com/Api/general_voucher.php?action=list';

  @override
  void onInit() {
    super.onInit();
    fetchVouchers();
  }

  Future<void> fetchVouchers() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['success'] == true && data['items'] != null) {
          final List<dynamic> items = data['items'];
          voucherList.value = items.map((e) => Voucher.fromJson(e)).toList();
          filteredVouchers.value = voucherList;
        } else {
          errorMessage.value = data['message'] ?? 'No vouchers found';
        }
      } else {
        errorMessage.value = 'Failed to fetch vouchers: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
      print('Error fetching vouchers: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // 🔍 Search logic
  void searchVouchers(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  // 🧠 Apply all filters together
  void applyFilters() {
    List<Voucher> results = voucherList;

    // Search filter
    if (searchQuery.value.isNotEmpty) {
      final lowerQuery = searchQuery.value.toLowerCase().trim();
      results = results.where((v) {
        return v.voucherNo?.toLowerCase().contains(lowerQuery) == true ||
            v.description?.toLowerCase().contains(lowerQuery) == true ||
            v.billTo?.toLowerCase().contains(lowerQuery) == true;
      }).toList();
    }

    // Type filter
    if (selectedType.value != 'All') {
      results = results
          .where(
            (v) =>
                v.voucherType?.toLowerCase() ==
                selectedType.value.toLowerCase(),
          )
          .toList();
    }

    // Status filter
    if (selectedStatus.value != 'All') {
      results = results
          .where(
            (v) =>
                v.status?.toLowerCase() == selectedStatus.value.toLowerCase(),
          )
          .toList();
    }

    // Date filter (optional)
    if (fromDate.value.isNotEmpty && toDate.value.isNotEmpty) {
      try {
        DateTime start = DateTime.parse(fromDate.value);
        DateTime end = DateTime.parse(toDate.value);

        results = results.where((v) {
          if (v.voucherDate == null) return false;
          final d = DateTime.parse(v.voucherDate!);
          return d.isAfter(start.subtract(const Duration(days: 1))) &&
              d.isBefore(end.add(const Duration(days: 1)));
        }).toList();
      } catch (e) {
        print("Invalid date format in filter: $e");
      }
    }

    filteredVouchers.value = results;
  }

  // 🧹 Clear all filters
  void clearFilters() {
    selectedType.value = 'All';
    selectedStatus.value = 'All';
    fromDate.value = '';
    toDate.value = '';
    searchQuery.value = '';
    filteredVouchers.value = voucherList;
  }
}
