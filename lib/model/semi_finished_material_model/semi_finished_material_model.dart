class SemiFinishedMaterial {
  final String stockId;
  final String itemCode;
  final String itemName;
  final String categoryId;
  final String currentQuantity;
  final String unitOfMeasure;
  final double boxWeight;
  final String boxDimensions;
  final String outputType;
  final List<BomItem> bomItems;

  SemiFinishedMaterial({
    required this.stockId,
    required this.itemCode,
    required this.itemName,
    required this.categoryId,
    required this.currentQuantity,
    required this.unitOfMeasure,
    required this.boxWeight,
    required this.boxDimensions,
    required this.outputType,
    required this.bomItems,
  });

  factory SemiFinishedMaterial.fromJson(Map<String, dynamic> json) {
    var bomList = <BomItem>[];
    if (json['bom_items'] != null) {
      bomList = (json['bom_items'] as List)
          .map((e) => BomItem.fromJson(e))
          .toList();
    }

    return SemiFinishedMaterial(
      stockId: json['stock_id'] ?? '',
      itemCode: json['item_code'] ?? '',
      itemName: json['item_name'] ?? '',
      categoryId: json['category_id'] ?? '',
      currentQuantity: json['current_quantity']?.toString() ?? '0',
      unitOfMeasure: json['unit_of_measure'] ?? '',
      boxWeight: double.tryParse(json['box_weight'] ?? '0') ?? 0,
      boxDimensions: json['box_dimensions'] ?? '',
      outputType: json['output_type'] ?? '',
      bomItems: bomList,
    );
  }
}

class BomItem {
  final String productionId;
  final String rawMaterialId;
  final double quantityRequired;
  final String unitOfMeasure;
  final double wastagePercentage;

  BomItem({
    required this.productionId,
    required this.rawMaterialId,
    required this.quantityRequired,
    required this.unitOfMeasure,
    required this.wastagePercentage,
  });

  factory BomItem.fromJson(Map<String, dynamic> json) {
    return BomItem(
      productionId: json['production_id'],
      rawMaterialId: json['raw_material_id'],
      quantityRequired: double.tryParse(json['quantity_required'] ?? '0') ?? 0,
      unitOfMeasure: json['unit_of_measure'],
      wastagePercentage:
          double.tryParse(json['wastage_percentage'] ?? '0') ?? 0,
    );
  }
}
