class NutritionalInfo {
  final int energyKcal;
  final int proteinG;
  final int totalFatG;
  final int carbohydrateG;
  final int totalSugarG;
  final int saturatedFatG;
  final int monounsaturatedFatG;
  final int polyunsaturatedFatG;
  final int sodiumMg;
  final double ironMg;
  final int calciumMg;
  final int fiberG;
  final int cholesterolMg;
  final int vitaminCMg;
  final int vitaminDMcg;

  NutritionalInfo({
    required this.energyKcal,
    required this.proteinG,
    required this.totalFatG,
    required this.carbohydrateG,
    required this.totalSugarG,
    required this.saturatedFatG,
    required this.monounsaturatedFatG,
    required this.polyunsaturatedFatG,
    required this.sodiumMg,
    required this.ironMg,
    required this.calciumMg,
    required this.fiberG,
    required this.cholesterolMg,
    required this.vitaminCMg,
    required this.vitaminDMcg,
  });

  factory NutritionalInfo.fromJson(Map<String, dynamic> json) {
    return NutritionalInfo(
      energyKcal: json['energy_kcal'] ?? 0,
      proteinG: json['protein_g'] ?? 0,
      totalFatG: json['total_fat_g'] ?? 0,
      carbohydrateG: json['carbohydrate_g'] ?? 0,
      totalSugarG: json['total_sugar_g'] ?? 0,
      saturatedFatG: json['saturated_fat_g'] ?? 0,
      monounsaturatedFatG: json['monounsaturated_fat_g'] ?? 0,
      polyunsaturatedFatG: json['polyunsaturated_fat_g'] ?? 0,
      sodiumMg: json['sodium_mg'] != null
          ? double.tryParse(json['sodium_mg'].toString())?.toInt() ?? 0
          : 0,
      ironMg: json['iron_mg'] != null
          ? double.tryParse(json['iron_mg'].toString()) ?? 0.0
          : 0.0,
      calciumMg: json['calcium_mg'] != null
          ? double.tryParse(json['calcium_mg'].toString())?.toInt() ?? 0
          : 0,
      fiberG: json['fiber_g'] ?? 0,
      cholesterolMg: json['cholesterol_mg'] ?? 0,
      vitaminCMg: json['vitamin_c_mg'] ?? 0,
      vitaminDMcg: json['vitamin_d_mcg'] ?? 0,
    );
  }
}

class Product {
  final String productId;
  final String productName;
  final String variationValue; // can be empty string if null
  final String status; // can default to '0' if null
  final String productImage; // can use placeholder if null
  final String categoryName;
  final NutritionalInfo nutritionalInfo;

  Product({
    required this.productId,
    required this.productName,
    required this.variationValue,
    required this.status,
    required this.productImage,
    required this.categoryName,
    required this.nutritionalInfo,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id']?.toString() ?? '',
      productName: json['product_name']?.toString() ?? '',
      variationValue: json['variation_value']?.toString() ?? '',
      status: json['status']?.toString() ?? '0',
      productImage:
          json['product_image']?.toString() ?? 'asset/images/home/khaman.png',
      categoryName: json['category_name']?.toString() ?? '',
      nutritionalInfo: NutritionalInfo.fromJson(json['nutritional_info'] ?? {}),
    );
  }
}
