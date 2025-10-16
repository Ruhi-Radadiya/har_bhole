// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
//
// class EditProductController extends GetxController {
//   // ===== Product ID for editing =====
//   final productId = "".obs;
//
//   // ===== Old fields =====
//   final productCodeController = TextEditingController();
//   final manufacturingDateController = TextEditingController();
//   final expiryDateController = TextEditingController();
//   final productTags = <String>[
//     'Best Seller',
//     'Gluten Free',
//     'Organic',
//     'Popular',
//     'Spicy',
//     'Sweet',
//     'Vegan',
//   ].obs;
//   final isActive = true.obs;
//   final selectedManufacturingDate = DateTime.now().obs;
//   final selectedExpiryDate = DateTime.now().obs;
//
//   final selectedCategory = "1".obs;
//   final selectedTags = <String>{}.obs;
//
//   // ===== Product data =====
//   final productNameController = TextEditingController();
//   final basePriceController = TextEditingController();
//   final sellingPriceController = TextEditingController();
//   final stockController = TextEditingController();
//   final netWeightController = TextEditingController();
//   final ingredientsListController = TextEditingController();
//
//   // ===== Nutritional info controllers =====
//   final energyController = TextEditingController();
//   final proteinController = TextEditingController();
//   final totalFatController = TextEditingController();
//   final carbohydrateController = TextEditingController();
//   final totalSugarController = TextEditingController();
//   final saturatedFatController = TextEditingController();
//   final monounsaturatedFatController = TextEditingController();
//   final polyunsaturatedFatController = TextEditingController();
//   final sodiumController = TextEditingController();
//   final ironController = TextEditingController();
//   final calciumController = TextEditingController();
//   final fiberController = TextEditingController();
//   final vitaminCController = TextEditingController();
//   final vitaminDController = TextEditingController();
//   final cholesterolController = TextEditingController();
//
//   // ===== Image =====
//   File? selectedImage;
//
//   void setImage(File image) {
//     selectedImage = image;
//   }
//
//   void setProductId(String id) {
//     productId.value = id;
//     loadProductData(); // Auto-load data when ID is set
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     // Load data if product ID is already set
//     if (productId.value.isNotEmpty) {
//       loadProductData();
//     }
//   }
//
//   // ===== LOAD EXISTING PRODUCT DATA =====
//   Future<void> loadProductData() async {
//     if (productId.value.isEmpty) {
//       print('❌ Product ID is empty');
//       return;
//     }
//
//     try {
//       print('🔄 Loading product data for ID: ${productId.value}');
//       final response = await http.get(
//         Uri.parse('https://harbhole.eihlims.com/Api/product_api.php?action=get&product_id=${productId.value}'),
//       );
//
//       print('📡 API Response Status: ${response.statusCode}');
//       print('📡 API Response Body: ${response.body}');
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['success'] == true && data['product'] != null) {
//           print('✅ Product data loaded successfully');}
//           final product = data['product'];
//
//           // Basic product info
//           productNameController.text = product['product_name'] ?? '';
//           selectedCategory.value = product['category_id']?.toString() ?? '1';
//           stockController.text = product['stock_quantity']?.toString() ?? '';
//           netWeightController.text = product['net_weight']?.toString() ?? '';
//           basePriceController.text = product['mrp']?.toString() ?? '';
//           sellingPriceController.text = product['selling_price']?.toString() ?? '';
//           ingredientsListController.text = product['ingredients'] ?? '';
//
//           // Dates
//           if (product['manufacturing_date'] != null) {
//             selectedManufacturingDate.value = DateTime.parse(product['manufacturing_date']);
//           }
//           if (product['expiry_date'] != null) {
//             selectedExpiryDate.value = DateTime.parse(product['expiry_date']);
//           }
//
//           // Tags
//           if (product['tags'] != null && product['tags'].toString().isNotEmpty) {
//             selectedTags.clear();
//             selectedTags.addAll(product['tags'].toString().split(','));
//           }
//
//           // Nutritional info
//           energyController.text = product['energy_kcal']?.toString() ?? '';
//           proteinController.text = product['protein_g']?.toString() ?? '';
//           totalFatController.text = product['total_fat_g']?.toString() ?? '';
//           carbohydrateController.text = product['carbohydrate_g']?.toString() ?? '';
//           totalSugarController.text = product['total_sugar_g']?.toString() ?? '';
//           saturatedFatController.text = product['saturated_fat_g']?.toString() ?? '';
//           monounsaturatedFatController.text = product['monounsaturated_fat_g']?.toString() ?? '';
//           polyunsaturatedFatController.text = product['polyunsaturated_fat_g']?.toString() ?? '';
//           sodiumController.text = product['sodium_mg']?.toString() ?? '';
//           ironController.text = product['iron_mg']?.toString() ?? '';
//           calciumController.text = product['calcium_mg']?.toString() ?? '';
//           fiberController.text = product['fiber_g']?.toString() ?? '';
//           vitaminCController.text = product['vitamin_c_mg']?.toString() ?? '';
//           vitaminDController.text = product['vitamin_d_mcg']?.toString() ?? '';
//           cholesterolController.text = product['cholesterol_mg']?.toString() ?? '';
//
//           print('✅ All fields populated successfully');
//         } else {
//           print('❌ API returned success=false or no product data');
//         }
//       } else {
//         print('❌ API request failed with status: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('❌ Error loading product data: $e');
//       Get.snackbar('Error', 'Failed to load product data: $e');
//     }
//   }
//
//   // ===== SET PRODUCT DATA MANUALLY =====

//   void setProductData(Map<String, dynamic> productData) {
//     productNameController.text = productData['product_name'] ?? '';
//     selectedCategory.value = productData['category_id']?.toString() ?? '1';
//     stockController.text = productData['stock_quantity']?.toString() ?? '';
//     netWeightController.text = productData['net_weight']?.toString() ?? '';
//     basePriceController.text = productData['mrp']?.toString() ?? '';
//     sellingPriceController.text = productData['selling_price']?.toString() ?? '';
//     ingredientsListController.text = productData['ingredients'] ?? '';
//
//     // Nutritional data
//     energyController.text = productData['energy_kcal']?.toString() ?? '';
//     proteinController.text = productData['protein_g']?.toString() ?? '';
//     totalFatController.text = productData['total_fat_g']?.toString() ?? '';
//     carbohydrateController.text = productData['carbohydrate_g']?.toString() ?? '';
//     totalSugarController.text = productData['total_sugar_g']?.toString() ?? '';
//
//     // Tags
//     if (productData['tags'] != null && productData['tags'].toString().isNotEmpty) {
//       selectedTags.clear();
//       selectedTags.addAll(productData['tags'].toString().split(','));
//     }
//   }
//
//   // ===== UPDATE PRODUCT WITH IMAGE =====
//   Future<bool> updateProduct() async {
//     try {
//       final uri = Uri.parse(
//         "https://harbhole.eihlims.com/Api/product_api.php?action=edit",
//       );
//       final request = http.MultipartRequest('POST', uri);
//
//       // Add text fields
//       final Map<String, String> fields = {
//         "product_id": productId.value,
//         "product_name": productNameController.text,
//         "category_id": selectedCategory.value,
//         "stock_quantity": stockController.text,
//         "net_weight":
//             double.tryParse(netWeightController.text)?.toStringAsFixed(3) ??
//             "0.000",
//         "mrp":
//             double.tryParse(basePriceController.text)?.toStringAsFixed(2) ??
//             "0.00",
//         "selling_price":
//             double.tryParse(sellingPriceController.text)?.toStringAsFixed(2) ??
//             "0.00",
//         "manufacturing_date": selectedManufacturingDate.value
//             .toIso8601String()
//             .split('T')[0],
//         "expiry_date": selectedExpiryDate.value.toIso8601String().split('T')[0],
//         "stock_status": "1",
//         "ingredients": ingredientsListController.text,
//         "tags": selectedTags.isEmpty ? "" : selectedTags.join(","),
//         "status": "1",
//         "energy_kcal":
//             double.tryParse(energyController.text)?.toStringAsFixed(2) ??
//             "0.00",
//         "protein_g":
//             double.tryParse(proteinController.text)?.toStringAsFixed(2) ??
//             "0.00",
//         "total_fat_g":
//             double.tryParse(totalFatController.text)?.toStringAsFixed(2) ??
//             "0.00",
//         "carbohydrate_g":
//             double.tryParse(carbohydrateController.text)?.toStringAsFixed(2) ??
//             "0.00",
//         "total_sugar_g":
//             double.tryParse(totalSugarController.text)?.toStringAsFixed(2) ??
//             "0.00",
//         "saturated_fat_g":
//             double.tryParse(saturatedFatController.text)?.toStringAsFixed(2) ??
//             "0.00",
//         "monounsaturated_fat_g":
//             double.tryParse(
//               monounsaturatedFatController.text,
//             )?.toStringAsFixed(2) ??
//             "0.00",
//         "polyunsaturated_fat_g":
//             double.tryParse(
//               polyunsaturatedFatController.text,
//             )?.toStringAsFixed(2) ??
//             "0.00",
//         "sodium_mg":
//             double.tryParse(sodiumController.text)?.toStringAsFixed(2) ??
//             "0.00",
//         "iron_mg":
//             double.tryParse(ironController.text)?.toStringAsFixed(2) ?? "0.00",
//         "calcium_mg":
//             double.tryParse(calciumController.text)?.toStringAsFixed(2) ??
//             "0.00",
//         "fiber_g":
//             double.tryParse(fiberController.text)?.toStringAsFixed(2) ?? "0.00",
//         "vitamin_c_mg":
//             double.tryParse(vitaminCController.text)?.toStringAsFixed(2) ??
//             "0.00",
//         "vitamin_d_mcg":
//             double.tryParse(vitaminDController.text)?.toStringAsFixed(2) ??
//             "0.00",
//         "cholesterol_mg":
//             double.tryParse(cholesterolController.text)?.toStringAsFixed(2) ??
//             "0.00",
//       };
//
//       request.fields.addAll(fields);
//
//       // Add image if selected
//       if (selectedImage != null) {
//         request.files.add(
//           await http.MultipartFile.fromPath(
//             'image',
//             selectedImage!.path,
//           ),
//         );
//       }
//
//       // Send request
//       final streamedResponse = await request.send();
//       final response = await http.Response.fromStream(streamedResponse);
//
//       print("🔁 Status: ${response.statusCode}");
//       print("🔁 Body: ${response.body}");
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         Get.snackbar(
//           "Success",
//           "Product updated successfully",
//           snackPosition: SnackPosition.BOTTOM,
//         );
//         return true;
//       } else {
//         Get.snackbar(
//           "Error",
//           "Failed to update product",
//           snackPosition: SnackPosition.BOTTOM,
//         );
//         return false;
//       }
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "Something went wrong: $e",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return false;
//     }
//   }
//
//   void toggleTag(String tag) {
//     if (selectedTags.contains(tag)) {
//       selectedTags.remove(tag);
//     } else {
//       selectedTags.add(tag);
//     }
//   }
//
//   void clearFields() {
//     productId.value = "";
//     productCodeController.clear();
//     manufacturingDateController.clear();
//     expiryDateController.clear();
//     productNameController.clear();
//     basePriceController.clear();
//     sellingPriceController.clear();
//     stockController.clear();
//     netWeightController.clear();
//     ingredientsListController.clear();
//
//     // Nutritional
//     energyController.clear();
//     proteinController.clear();
//     totalFatController.clear();
//     carbohydrateController.clear();
//     totalSugarController.clear();
//     saturatedFatController.clear();
//     monounsaturatedFatController.clear();
//     polyunsaturatedFatController.clear();
//     sodiumController.clear();
//     ironController.clear();
//     calciumController.clear();
//     fiberController.clear();
//     vitaminCController.clear();
//     vitaminDController.clear();
//     cholesterolController.clear();
//
//     selectedCategory.value = "1";
//     selectedTags.clear();
//     isActive.value = true;
//     selectedImage = null;
//   }
// }
