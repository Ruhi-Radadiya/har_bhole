// models/product_model.dart
class Product {
  String id;
  String productCode;
  String productName;
  String category;
  String description;
  double mrp;
  double sellingPrice;
  int stockQuantity;
  double netWeight;
  String stockStatus;
  String? manufacturingDate;
  String? expiryDate;
  String ingredients;
  bool isActive;
  String imageUrl;
  DateTime createdAt;

  Product({
    required this.id,
    required this.productCode,
    required this.productName,
    required this.category,
    required this.description,
    required this.mrp,
    required this.sellingPrice,
    required this.stockQuantity,
    required this.netWeight,
    required this.stockStatus,
    this.manufacturingDate,
    this.expiryDate,
    required this.ingredients,
    required this.isActive,
    required this.imageUrl,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productCode': productCode,
      'productName': productName,
      'category': category,
      'description': description,
      'mrp': mrp,
      'sellingPrice': sellingPrice,
      'stockQuantity': stockQuantity,
      'netWeight': netWeight,
      'stockStatus': stockStatus,
      'manufacturingDate': manufacturingDate,
      'expiryDate': expiryDate,
      'ingredients': ingredients,
      'isActive': isActive,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      productCode: json['productCode'] ?? '',
      productName: json['productName'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      mrp:
          (json['mrp'] is int
              ? (json['mrp'] as int).toDouble()
              : json['mrp']) ??
          0.0,
      sellingPrice:
          (json['sellingPrice'] is int
              ? (json['sellingPrice'] as int).toDouble()
              : json['sellingPrice']) ??
          0.0,
      stockQuantity: json['stockQuantity'] ?? 0,
      netWeight:
          (json['netWeight'] is int
              ? (json['netWeight'] as int).toDouble()
              : json['netWeight']) ??
          0.0,
      stockStatus: json['stockStatus'] ?? 'In Stock',
      manufacturingDate: json['manufacturingDate'],
      expiryDate: json['expiryDate'],
      ingredients: json['ingredients'] ?? '',
      isActive: json['isActive'] ?? true,
      imageUrl: json['imageUrl'] ?? 'asset/images/home/samosa.png',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }
}
