import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final RxList<Product> products = <Product>[].obs;
  final Rx<Product?> selectedProduct = Rx<Product?>(null);
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;

  final GetStorage _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _initializeStorage();
  }

  // Initialize storage and load products
  Future<void> _initializeStorage() async {
    await GetStorage.init();
    loadProducts();
  }

  // Load products from GetStorage
  Future<void> loadProducts() async {
    try {
      isLoading.value = true;

      final productsData = _storage.read<List<dynamic>>('products');

      if (productsData != null && productsData.isNotEmpty) {
        products.assignAll(
          productsData
              .map((json) => Product.fromJson(Map<String, dynamic>.from(json)))
              .toList(),
        );
      } else {
        // Add sample data if no products exist
        await _addSampleProducts();
      }
    } catch (e) {
      print('Error loading products: $e');
      // If there's an error, add sample products
      await _addSampleProducts();
    } finally {
      isLoading.value = false;
    }
  }

  // Add sample products
  Future<void> _addSampleProducts() async {
    final sampleProducts = [
      Product(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        productCode: '25110048',
        productName: 'Rajvadi Peda',
        category: 'Sweet',
        description: 'Traditional Indian sweet',
        mrp: 600.0,
        sellingPrice: 500.0,
        stockQuantity: 50,
        netWeight: 500.0,
        stockStatus: 'In Stock',
        manufacturingDate: '2024-01-01',
        expiryDate: '2024-12-31',
        ingredients: 'Milk, Sugar, Ghee, Cardamom',
        isActive: true,
        imageUrl: 'asset/images/home/samosa.png',
        createdAt: DateTime.now(),
      ),
      Product(
        id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
        productCode: '25110049',
        productName: 'White Farani Chevdo',
        category: 'Snacks',
        description: 'Spicy snack mix',
        mrp: 300.0,
        sellingPrice: 250.0,
        stockQuantity: 0,
        netWeight: 1000.0,
        stockStatus: 'Out Of Stock',
        manufacturingDate: '2024-01-15',
        expiryDate: '2024-06-30',
        ingredients: 'Poha, Nuts, Spices, Oil',
        isActive: false,
        imageUrl: 'asset/images/about/jalebi.png',
        createdAt: DateTime.now(),
      ),
    ];

    products.assignAll(sampleProducts);
    await _saveProducts();
  }

  // Save products to GetStorage
  Future<void> _saveProducts() async {
    try {
      final productsJson = products.map((product) => product.toJson()).toList();
      await _storage.write('products', productsJson);
    } catch (e) {
      print('Error saving products: $e');
      rethrow;
    }
  }

  // Add new product
  Future<void> addProduct(Product product) async {
    try {
      isLoading.value = true;
      products.add(product);
      await _saveProducts();
      Get.back();
      Get.snackbar(
        'Success',
        'Product added successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add product: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      // Revert the change if save fails
      products.remove(product);
    } finally {
      isLoading.value = false;
    }
  }

  // Update product
  Future<void> updateProduct(Product updatedProduct) async {
    try {
      isLoading.value = true;
      final index = products.indexWhere((p) => p.id == updatedProduct.id);
      if (index != -1) {
        final oldProduct = products[index];
        products[index] = updatedProduct;
        try {
          await _saveProducts();
          Get.back();
          Get.snackbar(
            'Success',
            'Product updated successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } catch (e) {
          // Revert if save fails
          products[index] = oldProduct;
          rethrow;
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update product: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Delete product
  Future<void> deleteProduct(String productId) async {
    try {
      isLoading.value = true;
      final productToRemove = products.firstWhere((p) => p.id == productId);
      products.removeWhere((p) => p.id == productId);
      try {
        await _saveProducts();
        Get.back();
        Get.snackbar(
          'Success',
          'Product deleted successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } catch (e) {
        // Revert if save fails
        products.add(productToRemove);
        rethrow;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete product: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Set selected product for details view
  void setSelectedProduct(Product product) {
    selectedProduct.value = product;
  }

  // Clear selected product
  void clearSelectedProduct() {
    selectedProduct.value = null;
  }

  // Search products
  List<Product> get filteredProducts {
    if (searchQuery.isEmpty) return products;
    return products
        .where(
          (product) =>
              product.productName.toLowerCase().contains(
                searchQuery.toLowerCase(),
              ) ||
              product.productCode.contains(searchQuery) ||
              product.category.toLowerCase().contains(
                searchQuery.toLowerCase(),
              ),
        )
        .toList();
  }

  // Get product by ID
  Product? getProductById(String id) {
    try {
      return products.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get status color
  Color getStatusColor(String status) {
    switch (status) {
      case 'In Stock':
        return const Color(0xff4E6B37);
      case 'Low Stock':
        return const Color(0xffA67014);
      case 'Out Of Stock':
        return const Color(0xffB52934);
      case 'Active':
        return const Color(0xff4E6B37);
      case 'INActive':
        return const Color(0xffAD111E);
      default:
        return Colors.grey;
    }
  }

  // Get status background color
  Color getStatusBgColor(String status) {
    switch (status) {
      case 'In Stock':
        return const Color(0xffBDDD9D);
      case 'Low Stock':
        return const Color(0xffF0D996);
      case 'Out Of Stock':
        return const Color(0xffEFCFD2);
      case 'Active':
        return const Color(0xffDCE1D7);
      case 'INActive':
        return const Color(0xffEFCFD2);
      default:
        return Colors.grey.shade200;
    }
  }

  // Calculate stock status based on quantity
  String calculateStockStatus(int quantity) {
    if (quantity == 0) return 'Out Of Stock';
    if (quantity < 10) return 'Low Stock';
    return 'In Stock';
  }

  // Clear all products (for testing/debugging)
  Future<void> clearAllProducts() async {
    products.clear();
    await _storage.remove('products');
  }

  // Get total products count
  int get totalProducts => products.length;

  // Get active products count
  int get activeProductsCount => products.where((p) => p.isActive).length;

  // Get out of stock products count
  int get outOfStockCount =>
      products.where((p) => p.stockStatus == 'Out Of Stock').length;
}
