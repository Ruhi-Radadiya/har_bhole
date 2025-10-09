class B2BOrder {
  final String id;
  final String orderNo;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final String customerAddress;
  final String status;
  final String paymentStatus;
  final String totalAmount;
  final String createdAt;
  final String customerCompany;
  final String customerGst;
  final List<OrderItem> items; // <-- added

  B2BOrder({
    required this.id,
    required this.orderNo,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.customerAddress,
    required this.status,
    required this.paymentStatus,
    required this.totalAmount,
    required this.createdAt,
    required this.customerCompany,
    required this.customerGst,
    required this.items,
  });

  factory B2BOrder.fromJson(Map<String, dynamic> json) {
    var itemsJson = json['items'] as List? ?? [];
    List<OrderItem> orderItems = itemsJson
        .map((item) => OrderItem.fromJson(item))
        .toList();

    return B2BOrder(
      id: json['id'],
      orderNo: json['order_no'],
      customerName: json['customer_name'],
      customerEmail: json['customer_email'],
      customerPhone: json['customer_phone'],
      customerAddress: json['customer_address'],
      status: json['status'],
      paymentStatus: json['payment_status'],
      totalAmount: json['total_amount'],
      createdAt: json['created_at'],
      customerCompany: json['customer_company'],
      customerGst: json['customer_gst'],
      items: orderItems,
    );
  }
}

class OrderItem {
  final String id;
  final String orderId;
  final String productId;
  final String productName;
  final String variationId;
  final String variationName;
  final String variationValue;
  final String quantity;
  final String price;
  final String total;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.variationId,
    required this.variationName,
    required this.variationValue,
    required this.quantity,
    required this.price,
    required this.total,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      productName: json['product_name'],
      variationId: json['variation_id'],
      variationName: json['variation_name'],
      variationValue: json['variation_value'],
      quantity: json['quantity'],
      price: json['price'],
      total: json['total'],
    );
  }
}
