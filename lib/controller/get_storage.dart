// services/storage_service.dart
import 'package:get_storage/get_storage.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  final GetStorage _box = GetStorage();

  // Initialize GetStorage
  Future<void> init() async {
    await GetStorage.init();
  }

  // Save products
  Future<void> saveProducts(List<Map<String, dynamic>> products) async {
    await _box.write('products', products);
  }

  // Load products
  List<Map<String, dynamic>>? loadProducts() {
    final products = _box.read<List<dynamic>>('products');
    if (products != null) {
      return products.cast<Map<String, dynamic>>();
    }
    return null;
  }

  // Clear all data
  Future<void> clearAll() async {
    await _box.erase();
  }
}
