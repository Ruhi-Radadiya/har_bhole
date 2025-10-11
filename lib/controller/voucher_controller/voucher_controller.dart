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

  void searchVouchers(String query) {
    if (query.isEmpty) {
      filteredVouchers.value = voucherList;
    } else {
      final lowerQuery = query.toLowerCase().trim();
      filteredVouchers.value = voucherList.where((v) {
        return v.voucherNo?.toLowerCase().contains(lowerQuery) == true ||
            v.description?.toLowerCase().contains(lowerQuery) == true ||
            v.billTo?.toLowerCase().contains(lowerQuery) == true;
      }).toList();
    }
  }
}
