import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/home_page_models/premium_collection_model.dart';

class PremiumCollectionController extends GetxController {
  // Observables
  var premiumCollection = <PremiumCollectionModel>[].obs;
  var filteredCategories = <PremiumCollectionModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var selectedCategory = ''.obs;

  final String baseUrl =
      'https://harbhole.eihlims.com/Api/category_api.php?action=list';

  @override
  void onInit() {
    super.onInit();
    fetchPremiumCollection();
  }

  Future<void> fetchPremiumCollection() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['items'] == null || (data['items'] as List).isEmpty) {
          errorMessage.value = 'No categories found';
          return;
        }

        // Map API items to model
        final List<PremiumCollectionModel> allCategories =
            (data['items'] as List)
                .map((e) => PremiumCollectionModel.fromJson(e))
                .toList();

        // Keep all categories, even duplicates
        premiumCollection.value = allCategories;

        // Initialize filteredCategories
        filteredCategories.value = List<PremiumCollectionModel>.from(
          premiumCollection,
        );
      } else {
        errorMessage.value =
            'Failed to fetch categories: ${response.statusCode}';
        log("Error********** :  ${response.statusCode}");
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
      log("Error********** : $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Search categories by name
  void searchCategories(String query) {
    if (query.isEmpty) {
      filteredCategories.value = premiumCollection;
    } else {
      final lowerQuery = query.toLowerCase().trim();
      filteredCategories.value = premiumCollection.where((cat) {
        return cat.categoryName.toLowerCase().contains(lowerQuery);
      }).toList();
    }
  }
}
