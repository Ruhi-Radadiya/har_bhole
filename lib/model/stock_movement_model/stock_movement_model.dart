class StockMovementModel {
  final String movementId;
  final String stockType;
  final String stockId;
  final String movementType;
  final String quantity;
  final String unitPrice;
  final String totalValue;
  final String referenceType;
  final String referenceId;
  final String referenceNumber;
  final String fromLocation;
  final String toLocation;
  final String batchNumber;
  final String notes;
  final String createdBy;
  final String createdAt;

  StockMovementModel({
    required this.movementId,
    required this.stockType,
    required this.stockId,
    required this.movementType,
    required this.quantity,
    required this.unitPrice,
    required this.totalValue,
    required this.referenceType,
    required this.referenceId,
    required this.referenceNumber,
    required this.fromLocation,
    required this.toLocation,
    required this.batchNumber,
    required this.notes,
    required this.createdBy,
    required this.createdAt,
  });

  factory StockMovementModel.fromJson(Map<String, dynamic> json) {
    return StockMovementModel(
      movementId: json['movement_id'] ?? '',
      stockType: json['stock_type'] ?? '',
      stockId: json['stock_id'] ?? '',
      movementType: json['movement_type'] ?? '',
      quantity: json['quantity'] ?? '',
      unitPrice: json['unit_price'] ?? '',
      totalValue: json['total_value'] ?? '',
      referenceType: json['reference_type'] ?? '',
      referenceId: json['reference_id'] ?? '',
      referenceNumber: json['reference_number'] ?? '',
      fromLocation: json['from_location'] ?? '',
      toLocation: json['to_location'] ?? '',
      batchNumber: json['batch_number'] ?? '',
      notes: json['notes'] ?? '',
      createdBy: json['created_by'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}
