class SemiFinishedMaterialModel {
  final String stockId;
  final String itemCode;
  final String itemName;
  final String categoryId;
  final String currentQuantity;
  final String unitOfMeasure;
  final String reorderPoint;
  final String? location;
  final String? description;
  final String outputType;
  final String boxWeight;
  final String boxDimensions;
  final String? itemImage;
  final String createdBy;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<BomItem> bomItems;

  SemiFinishedMaterialModel({
    required this.stockId,
    required this.itemCode,
    required this.itemName,
    required this.categoryId,
    required this.currentQuantity,
    required this.unitOfMeasure,
    required this.reorderPoint,
    this.location,
    this.description,
    required this.outputType,
    required this.boxWeight,
    required this.boxDimensions,
    this.itemImage,
    required this.createdBy,
    required this.createdAt,
    this.updatedAt,
    required this.bomItems,
  });

  factory SemiFinishedMaterialModel.fromJson(
    Map<String, dynamic> json,
  ) => SemiFinishedMaterialModel(
    stockId: json["stock_id"] ?? '',
    itemCode: json["item_code"] ?? '',
    itemName: json["item_name"] ?? '',
    categoryId: json["category_id"] ?? '',
    currentQuantity: json["current_quantity"] ?? '0',
    unitOfMeasure: json["unit_of_measure"] ?? '',
    reorderPoint: json["reorder_point"] ?? '0',
    location: json["location"],
    description: json["description"],
    outputType: json["output_type"] ?? '',
    boxWeight: json["box_weight"] ?? '0',
    boxDimensions: json["box_dimensions"] ?? '',
    itemImage: json["item_image"],
    createdBy: json["created_by"] ?? 'Unknown',
    createdAt: DateTime.tryParse(json["created_at"] ?? '') ?? DateTime.now(),
    updatedAt: json["updated_at"] != null
        ? DateTime.tryParse(json["updated_at"])
        : null,
    bomItems: json["bom_items"] != null
        ? List<BomItem>.from(json["bom_items"].map((x) => BomItem.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "stock_id": stockId,
    "item_code": itemCode,
    "item_name": itemName,
    "category_id": categoryId,
    "current_quantity": currentQuantity,
    "unit_of_measure": unitOfMeasure,
    "reorder_point": reorderPoint,
    "location": location,
    "description": description,
    "output_type": outputType,
    "box_weight": boxWeight,
    "box_dimensions": boxDimensions,
    "item_image": itemImage,
    "created_by": createdBy,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "bom_items": List<dynamic>.from(bomItems.map((x) => x.toJson())),
  };
}

class BomItem {
  final String? productionId;
  final String rawMaterialId;
  final String quantityRequired;
  final String unitOfMeasure;
  final String wastagePercentage;
  final String? notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BomItem({
    this.productionId,
    required this.rawMaterialId,
    required this.quantityRequired,
    required this.unitOfMeasure,
    required this.wastagePercentage,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory BomItem.fromJson(Map<String, dynamic> json) => BomItem(
    productionId: json["production_id"] ?? '',
    rawMaterialId: json["raw_material_id"] ?? '',
    quantityRequired: json["quantity_required"] ?? '0',
    unitOfMeasure: json["unit_of_measure"] ?? '',
    wastagePercentage: json["wastage_percentage"] ?? '0',
    notes: json["notes"],
    createdAt: json["created_at"] != null
        ? DateTime.tryParse(json["created_at"])
        : null,
    updatedAt: json["updated_at"] != null
        ? DateTime.tryParse(json["updated_at"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "production_id": productionId,
    "raw_material_id": rawMaterialId,
    "quantity_required": quantityRequired,
    "unit_of_measure": unitOfMeasure,
    "wastage_percentage": wastagePercentage,
    "notes": notes,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
