class FinishedGoodsStockModel {
  String? stockId;
  String? productCode;
  String? productName;
  String? categoryId;
  String? currentQuantity;
  String? unitOfMeasure;
  String? reorderPoint;
  String? description;
  String? productImage;
  String? status;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<VariantsJson>? variantsJson;
  List<BomJson>? bomJson;
  String? producedTotalWeightGrams;
  String? categoryName;

  FinishedGoodsStockModel({
    this.stockId,
    this.productCode,
    this.productName,
    this.categoryId,
    this.currentQuantity,
    this.unitOfMeasure,
    this.reorderPoint,
    this.description,
    this.productImage,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.variantsJson,
    this.bomJson,
    this.producedTotalWeightGrams,
    this.categoryName,
  });

  factory FinishedGoodsStockModel.fromJson(Map<String, dynamic> json) {
    return FinishedGoodsStockModel(
      stockId: json["stock_id"]?.toString(),
      productCode: json["product_code"]?.toString(),
      productName: json["product_name"]?.toString(),
      categoryId: json["category_id"]?.toString(),
      currentQuantity: json["current_quantity"]?.toString() ?? '0',
      unitOfMeasure: json["unit_of_measure"]?.toString(),
      reorderPoint: json["reorder_point"]?.toString(),
      description: json["description"]?.toString() ?? '',
      productImage: json["product_image"]?.toString(),
      status: json["status"]?.toString(),
      createdBy: json["created_by"]?.toString(),
      createdAt: json["created_at"] != null
          ? DateTime.tryParse(json["created_at"])
          : null,
      updatedAt: json["updated_at"] != null
          ? DateTime.tryParse(json["updated_at"])
          : null,
      variantsJson: json["variants_json"] != null
          ? List<VariantsJson>.from(
              json["variants_json"].map((x) => VariantsJson.fromJson(x)),
            )
          : [],
      bomJson: json["bom_json"] != null
          ? List<BomJson>.from(json["bom_json"].map((x) => BomJson.fromJson(x)))
          : [],
      producedTotalWeightGrams: json["produced_total_weight_grams"]?.toString(),
      categoryName: json["category_name"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    "stock_id": stockId,
    "product_code": productCode,
    "product_name": productName,
    "category_id": categoryId,
    "current_quantity": currentQuantity,
    "unit_of_measure": unitOfMeasure,
    "reorder_point": reorderPoint,
    "description": description,
    "product_image": productImage,
    "status": status,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "variants_json": variantsJson != null
        ? variantsJson!.map((x) => x.toJson()).toList()
        : [],
    "bom_json": bomJson != null ? bomJson!.map((x) => x.toJson()).toList() : [],
    "produced_total_weight_grams": producedTotalWeightGrams,
    "category_name": categoryName,
  };
}

class BomJson {
  int? semiFinishedId;
  double? quantityRequired;
  String? unitOfMeasure;

  BomJson({this.semiFinishedId, this.quantityRequired, this.unitOfMeasure});

  factory BomJson.fromJson(Map<String, dynamic> json) => BomJson(
    semiFinishedId: json["semi_finished_id"],
    quantityRequired: (json["quantity_required"] != null)
        ? double.tryParse(json["quantity_required"].toString())
        : 0.0,
    unitOfMeasure: json["unit_of_measure"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "semi_finished_id": semiFinishedId,
    "quantity_required": quantityRequired,
    "unit_of_measure": unitOfMeasure,
  };
}

class VariantsJson {
  double? weightGrams;
  int? units;

  VariantsJson({this.weightGrams, this.units});

  factory VariantsJson.fromJson(Map<String, dynamic> json) => VariantsJson(
    weightGrams: (json["weight_grams"] != null)
        ? double.tryParse(json["weight_grams"].toString())
        : 0.0,
    units: (json["units"] != null) ? int.tryParse(json["units"].toString()) : 0,
  );

  Map<String, dynamic> toJson() => {
    "weight_grams": weightGrams,
    "units": units,
  };
}
