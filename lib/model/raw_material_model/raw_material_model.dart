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
      stockId: json['stock_id']?.toString() ?? '',
      materialCode: json['material_code']?.toString() ?? '',
      materialName: json['material_name']?.toString() ?? '',
      categoryId: json['category_id']?.toString() ?? '',
      currentQuantity: json['current_quantity']?.toString() ?? '0',
      unitOfMeasure: json['unit_of_measure']?.toString() ?? '',
      minStockLevel: json['min_stock_level']?.toString() ?? '',
      maxStockLevel: json['max_stock_level']?.toString() ?? '',
      reorderPoint: json['reorder_point']?.toString() ?? '',
      costPrice: json['cost_price']?.toString() ?? '',
      supplierId: json['supplier_id']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      materialImage: json['material_image']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      createdBy: json['created_by']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
      stock: (json['stock'] is num)
          ? (json['stock'] as num).toDouble()
          : double.tryParse(json['stock']?.toString() ?? '0') ?? 0.0,
      costPerUnit: (json['cost_per_unit'] is num)
          ? (json['cost_per_unit'] as num).toDouble()
          : double.tryParse(json['cost_per_unit']?.toString() ?? '0') ?? 0.0,
      totalValue: (json['total_value'] is num)
          ? (json['total_value'] as num).toDouble()
          : double.tryParse(json['total_value']?.toString() ?? '0') ?? 0.0,
      lowStockAlert: json['low_stock_alert'] == true,
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
      movementType: json['movement_type']?.toString() ?? '',
      changeQty: json['change_qty']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
    );
  }
}
