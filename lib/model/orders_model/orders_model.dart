class Order {
  String id;
  String orderNumber;
  String customerName;
  String customerMobile;
  String customerAddress;
  String totalAmount;
  String status;
  String paymentStatus;
  String paymentMethod;
  List<OrderProduct> products;
  String createdAt;

  Order({
    required this.id,
    required this.orderNumber,
    required this.customerName,
    required this.customerMobile,
    required this.customerAddress,
    required this.totalAmount,
    required this.status,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.products,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    final products = (json['products'] as List<dynamic>)
        .map((p) => OrderProduct.fromJson(p))
        .toList();

    return Order(
      id: json['id'],
      orderNumber: json['order_number'],
      customerName: json['customer_name'],
      customerMobile: json['customer_mobile'],
      customerAddress: json['customer_address'],
      totalAmount: json['total_amount'],
      status: json['status'],
      paymentStatus: json['payment_status'],
      paymentMethod: json['payment_method'],
      products: products,
      createdAt: json['created_at'],
    );
  }
}

class OrderProduct {
  int productId;
  String productName;
  double price;
  int quantity;
  double subtotal;
  String imagePath;
  String netWeight;

  OrderProduct({
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.subtotal,
    required this.imagePath,
    required this.netWeight,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      productId: json['product_id'],
      productName: json['product_name'],
      price: double.parse(json['price'].toString()),
      quantity: json['quantity'],
      subtotal: double.parse(json['subtotal'].toString()),
      imagePath: json['image_path'],
      netWeight: json['net_weight'],
    );
  }
}
