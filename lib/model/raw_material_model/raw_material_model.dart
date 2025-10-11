class RawMaterialModel {
  String? stockId;
  String? materialCode;
  String? materialName;
  String? categoryId;
  String? currentQuantity;
  String? unitOfMeasure;
  String? minStockLevel;
  String? maxStockLevel;
  String? reorderPoint;
  String? costPrice;
  String? supplierId;
  String? location;
  String? description;
  String? materialImage;
  String? status;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  double? stock;
  double? costPerUnit;
  double? totalValue;
  bool? lowStockAlert;
  RecentMovement? recentMovement;

  RawMaterialModel({
    this.stockId,
    this.materialCode,
    this.materialName,
    this.categoryId,
    this.currentQuantity,
    this.unitOfMeasure,
    this.minStockLevel,
    this.maxStockLevel,
    this.reorderPoint,
    this.costPrice,
    this.supplierId,
    this.location,
    this.description,
    this.materialImage,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.stock,
    this.costPerUnit,
    this.totalValue,
    this.lowStockAlert,
    this.recentMovement,
  });

  factory RawMaterialModel.fromJson(Map<String, dynamic> json) {
    return RawMaterialModel(
      stockId: json['stock_id'] ?? '',
      materialCode: json['material_code'] ?? '',
      materialName: json['material_name'] ?? '',
      categoryId: json['category_id'] ?? '',
      currentQuantity: json['currentQuantity']?.toString() ?? '0',
      unitOfMeasure: json['unit_of_measure'] ?? '',
      minStockLevel: json['min_stock_level'] ?? '',
      maxStockLevel: json['max_stock_level'] ?? '',
      reorderPoint: json['reorder_point'] ?? '',
      costPrice: json['cost_price'] ?? '',
      supplierId: json['supplier_id']?.toString(),
      location: json['location'] ?? '',
      description: json['description'] ?? '',
      materialImage: json['material_image'],
      status: json['status'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'] ?? '',
      stock: (json['stock'] ?? 0).toDouble(),
      costPerUnit: (json['cost_per_unit'] ?? 0).toDouble(),
      totalValue: (json['total_value'] ?? 0).toDouble(),
      lowStockAlert: json['low_stock_alert'] ?? false,
      recentMovement: json['recent_movement'] != null
          ? RecentMovement.fromJson(json['recent_movement'])
          : null,
    );
  }
}

class RecentMovement {
  String? movementType;
  String? changeQty;
  String? createdAt;

  RecentMovement({this.movementType, this.changeQty, this.createdAt});

  factory RecentMovement.fromJson(Map<String, dynamic> json) {
    return RecentMovement(
      movementType: json['movement_type'] ?? '',
      changeQty: json['change_qty'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}
