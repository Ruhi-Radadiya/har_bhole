class CartModel {
  final String id;
  final String? productId;
  final String productName;
  final String grams;
  String qty;
  final String price;
  final String total;
  final String createdAt;

  CartModel({
    required this.id,
    this.productId,
    required this.productName,
    required this.grams,
    required this.qty,
    required this.price,
    required this.total,
    required this.createdAt,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] ?? '',
      productId: json['product_id'],
      productName: json['product_name'] ?? '',
      grams: json['grams'] ?? '',
      qty: json['qty'] ?? '0',
      price: json['price'] ?? '0',
      total: json['total'] ?? '0',
      createdAt: json['created_at'] ?? '',
    );
  }
}
