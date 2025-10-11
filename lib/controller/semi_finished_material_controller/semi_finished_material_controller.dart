import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/semi_finished_material_model/semi_finished_material_model.dart';

class SemiFinishedController extends GetxController {
  static SemiFinishedController get instance => Get.find();

  var materials = <SemiFinishedMaterial>[].obs;
  var isLoading = true.obs;

  // Info card counts
  var totalItem = 0.obs;
  var inStock = 0.obs;
  var lowStock = 0.obs;
  var outOfStock = 0.obs;

  @override
  void onInit() {
    fetchMaterials();
    super.onInit();
  }

  // Fetch API data
  void fetchMaterials() async {
    isLoading.value = true;
    try {
      // Replace this URL with your real API endpoint
      final url = Uri.parse(
        'https://harbhole.eihlims.com/Api/semi_finished_stock_api.php?action=list',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data['success'] == true) {
          materials.value = (data['items'] as List)
              .map((e) => SemiFinishedMaterial.fromJson(e))
              .toList();

          _calculateStockInfo();
        }
      } else {
        print('API Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching materials: $e');
      _loadDummyData();
    } finally {
      isLoading.value = false;
    }
  }

  // Calculate stock info for info cards
  void _calculateStockInfo() {
    totalItem.value = materials.length;

    inStock.value = materials.where((m) {
      final qty = double.tryParse(m.currentQuantity) ?? 0;
      return qty > 10;
    }).length;

    lowStock.value = materials.where((m) {
      final qty = double.tryParse(m.currentQuantity) ?? 0;
      return qty > 0 && qty <= 10;
    }).length;

    outOfStock.value = materials.where((m) {
      final qty = double.tryParse(m.currentQuantity) ?? 0;
      return qty == 0;
    }).length;
  }

  // Dummy data fallback
  void _loadDummyData() {
    final dummy = [
      SemiFinishedMaterial(
        stockId: "27",
        itemCode: "SFS0027",
        itemName: "Sev (Medium)",
        categoryId: "19",
        currentQuantity: '0',
        unitOfMeasure: "kg",
        boxWeight: 1.2,
        boxDimensions: "30x20x10",
        outputType: "kg",
        bomItems: [
          BomItem(
            productionId: "98",
            rawMaterialId: "3",
            quantityRequired: 10,
            unitOfMeasure: "kg",
            wastagePercentage: 1,
          ),
          BomItem(
            productionId: "99",
            rawMaterialId: "7",
            quantityRequired: 2,
            unitOfMeasure: "kg",
            wastagePercentage: 0.5,
          ),
        ],
      ),
    ];

    materials.value = dummy;
    _calculateStockInfo();
  }
}
