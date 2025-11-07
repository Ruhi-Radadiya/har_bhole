class NutritionalInfo {
  final double? energyKcal;
  final double? proteinG;
  final double? totalFatG;
  final double? carbohydrateG;
  final double? totalSugarG;
  final double? saturatedFatG;
  final double? monounsaturatedFatG;
  final double? polyunsaturatedFatG;
  final double? sodiumMg;
  final double? ironMg;
  final double? calciumMg;
  final double? fiberG;
  final double? cholesterolMg;
  final double? vitaminCMg;
  final double? vitaminDMcg;

  NutritionalInfo({
    this.energyKcal,
    this.proteinG,
    this.totalFatG,
    this.carbohydrateG,
    this.totalSugarG,
    this.saturatedFatG,
    this.monounsaturatedFatG,
    this.polyunsaturatedFatG,
    this.sodiumMg,
    this.ironMg,
    this.calciumMg,
    this.fiberG,
    this.cholesterolMg,
    this.vitaminCMg,
    this.vitaminDMcg,
  });

  factory NutritionalInfo.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic val) {
      if (val == null) return 0.0;
      if (val is num) return val.toDouble();
      return double.tryParse(val.toString()) ?? 0.0;
    }

    return NutritionalInfo(
      energyKcal: parseDouble(json['energy_kcal']),
      proteinG: parseDouble(json['protein_g']),
      totalFatG: parseDouble(json['total_fat_g']),
      carbohydrateG: parseDouble(json['carbohydrate_g']),
      totalSugarG: parseDouble(json['total_sugar_g']),
      saturatedFatG: parseDouble(json['saturated_fat_g']),
      monounsaturatedFatG: parseDouble(json['monounsaturated_fat_g']),
      polyunsaturatedFatG: parseDouble(json['polyunsaturated_fat_g']),
      sodiumMg: parseDouble(json['sodium_mg']),
      ironMg: parseDouble(json['iron_mg']),
      calciumMg: parseDouble(json['calcium_mg']),
      fiberG: parseDouble(json['fiber_g']),
      cholesterolMg: parseDouble(json['cholesterol_mg']),
      vitaminCMg: parseDouble(json['vitamin_c_mg']),
      vitaminDMcg: parseDouble(json['vitamin_d_mcg']),
    );
  }
}

class Product {
  final String productId;
  final String productCode;
  final String productName;
  final String variationName;
  final String variationValue;
  final String status;
  final String productImage;
  final String categoryName;
  final double sellingPrice;
  final double netWeight;
  final double mrp;
  final int stockQuantity;
  final String manufacturingDate;
  final String expiryDate;
  final String ingredients;
  final String description;
  final String sku;
  final double priceAdjustment;
  final NutritionalInfo nutritionalInfo;
  final List<dynamic> variations;

  Product({
    required this.productId,
    required this.productCode,
    required this.productName,
    required this.variationName,
    required this.variationValue,
    required this.status,
    required this.productImage,
    required this.categoryName,
    required this.sellingPrice,
    required this.netWeight,
    required this.mrp,
    required this.stockQuantity,
    required this.manufacturingDate,
    required this.expiryDate,
    required this.ingredients,
    required this.description,
    required this.sku,
    required this.priceAdjustment,
    required this.nutritionalInfo,
    required this.variations,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic val) {
      if (val == null) return 0.0;
      if (val is num) return val.toDouble();
      return double.tryParse(val.toString()) ?? 0.0;
    }

    int parseInt(dynamic val) {
      if (val == null) return 0;
      if (val is int) return val;
      return int.tryParse(val.toString()) ?? 0;
    }

    return Product(
      productId: json['product_id']?.toString() ?? '',
      productCode: json['product_code']?.toString() ?? '',
      productName: json['product_name']?.toString() ?? '',
      variationName: json['variation_name']?.toString() ?? '',
      variationValue: json['variation_value']?.toString() ?? '',
      status: json['status']?.toString() ?? '0',
      productImage:
          json['product_image']?.toString() ??
          'https://harbhole.eihlims.com/images/no-image.png',
      categoryName: json['category_name']?.toString() ?? '',
      sellingPrice: parseDouble(json['selling_price']),
      netWeight: parseDouble(json['net_weight']),
      mrp: parseDouble(json['mrp']),
      stockQuantity: parseInt(json['stock_quantity']),
      manufacturingDate: json['manufacturing_date']?.toString() ?? '',
      expiryDate: json['expiry_date']?.toString() ?? '',
      ingredients: json['ingredients']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      sku: json['sku']?.toString() ?? '',
      priceAdjustment: parseDouble(json['price_adjustment']),
      nutritionalInfo: json['nutritional_info'] is Map<String, dynamic>
          ? NutritionalInfo.fromJson(json['nutritional_info'])
          : NutritionalInfo.fromJson({}),
      variations: json['variations'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_code': productCode,
      'product_name': productName,
      'variation_name': variationName,
      'variation_value': variationValue,
      'status': status,
      'product_image': productImage,
      'category_name': categoryName,
      'selling_price': sellingPrice,
      'net_weight': netWeight,
      'mrp': mrp,
      'stock_quantity': stockQuantity,
      'manufacturing_date': manufacturingDate,
      'expiry_date': expiryDate,
      'ingredients': ingredients,
      'description': description,
      'sku': sku,
      'price_adjustment': priceAdjustment,
      'nutritional_info': {
        'energy_kcal': nutritionalInfo.energyKcal,
        'protein_g': nutritionalInfo.proteinG,
        'total_fat_g': nutritionalInfo.totalFatG,
        'carbohydrate_g': nutritionalInfo.carbohydrateG,
        'total_sugar_g': nutritionalInfo.totalSugarG,
        'saturated_fat_g': nutritionalInfo.saturatedFatG,
        'monounsaturated_fat_g': nutritionalInfo.monounsaturatedFatG,
        'polyunsaturated_fat_g': nutritionalInfo.polyunsaturatedFatG,
        'sodium_mg': nutritionalInfo.sodiumMg,
        'iron_mg': nutritionalInfo.ironMg,
        'calcium_mg': nutritionalInfo.calciumMg,
        'fiber_g': nutritionalInfo.fiberG,
        'cholesterol_mg': nutritionalInfo.cholesterolMg,
        'vitamin_c_mg': nutritionalInfo.vitaminCMg,
        'vitamin_d_mcg': nutritionalInfo.vitaminDMcg,
      },
      'variations': variations,
    };
  }
}
