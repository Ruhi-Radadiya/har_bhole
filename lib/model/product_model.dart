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
      energyKcal: json['energy_kcal'],
      proteinG: json['protein_g'],
      totalFatG: json['total_fat_g'],
      carbohydrateG: json['carbohydrate_g'],
      totalSugarG: json['total_sugar_g'],
      saturatedFatG: json['saturated_fat_g'],
      monounsaturatedFatG: json['monounsaturated_fat_g'],
      polyunsaturatedFatG: json['polyunsaturated_fat_g'],
      sodiumMg: json['sodium_mg'],
      ironMg: (json['iron_mg'] as num).toDouble(),
      calciumMg: json['calcium_mg'],
      fiberG: json['fiber_g'],
      cholesterolMg: json['cholesterol_mg'],
      vitaminCMg: json['vitamin_c_mg'],
      vitaminDMcg: json['vitamin_d_mcg'],
    );
  }
}

class Product {
  final String productId;
  final String productName;
  final String variationValue;
  final String status;
  final String productImage;
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
      productId: json['product_id'],
      productName: json['product_name'],
      variationValue: json['variation_value'],
      status: json['status'],
      productImage: json['product_image'],
      categoryName: json['category_name'],
      nutritionalInfo: NutritionalInfo.fromJson(json['nutritional_info']),
    );
  }
}
