import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../component/product_page_component.dart';

class SavedProductsScreen extends StatefulWidget {
  const SavedProductsScreen({super.key});

  @override
  State<SavedProductsScreen> createState() => _SavedProductsScreenState();
}

class _SavedProductsScreenState extends State<SavedProductsScreen> {
  final box = GetStorage();
  List<Map<String, dynamic>> savedProducts = [];

  @override
  void initState() {
    super.initState();
    loadSavedProducts();
  }

  void loadSavedProducts() {
    // ✅ Load from GetStorage
    final List<dynamic>? data = box.read<List>('savedProducts');
    if (data != null && data.isNotEmpty) {
      savedProducts = List<Map<String, dynamic>>.from(data);
    } else {
      savedProducts = [];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Saved Products",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),

      body: savedProducts.isEmpty
          ? Center(
              child: Text(
                "No saved products yet!",
                style: GoogleFonts.poppins(
                  fontSize: Get.width / 25,
                  color: Colors.grey.shade600,
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.only(top: Get.height / 60),
              itemCount: savedProducts.length,
              itemBuilder: (context, index) {
                final item = savedProducts[index];
                return FoodItemContainer(
                  title: item['title'],
                  productId: item['productId'],
                  price: item['price'],
                  description: item['description'],
                  quantity: 0,
                  imageUrl: item['imageUrl'],
                  isFromSavedPage: true, // 👈 hides save & share icons
                );
              },
            ),
    );
  }
}
