class AllOrdersModel {
  final String id;
  final String orderNumber;
  final String customerName;
  final String customerMobile;
  final String? customerWhatsapp;
  final String customerAddress;
  final String customerZipcode;
  final String cartId;
  final String totalAmount;
  final String status;
  final String paymentStatus;
  final String paymentMethod;
  final List<AllProduct> products;
  final String? notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? razorpayOrderId;
  final String? razorpayPaymentId;
  final String? razorpaySignature;

  AllOrdersModel({
    required this.id,
    required this.orderNumber,
    required this.customerName,
    required this.customerMobile,
    this.customerWhatsapp,
    required this.customerAddress,
    required this.customerZipcode,
    required this.cartId,
    required this.totalAmount,
    required this.status,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.products,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.razorpayOrderId,
    this.razorpayPaymentId,
    this.razorpaySignature,
  });

  factory AllOrdersModel.fromJson(Map<String, dynamic> json) => AllOrdersModel(
    id: json["id"].toString(),
    orderNumber: json["order_number"] ?? '',
    customerName: json["customer_name"] ?? '',
    customerMobile: json["customer_mobile"] ?? '',
    customerWhatsapp: json["customer_whatsapp"],
    customerAddress: json["customer_address"] ?? '',
    customerZipcode: json["customer_zipcode"] ?? '',
    cartId: json["cart_id"] ?? '',
    totalAmount: json["total_amount"].toString(),
    status: json["status"] ?? '',
    paymentStatus: json["payment_status"] ?? '',
    paymentMethod: json["payment_method"] ?? '',
    products: json["products"] == null
        ? []
        : List<AllProduct>.from(
            json["products"].map((x) => AllProduct.fromJson(x)),
          ),
    notes: json["notes"],
    createdAt: DateTime.tryParse(json["created_at"] ?? ''),
    updatedAt: DateTime.tryParse(json["updated_at"] ?? ''),
    razorpayOrderId: json["razorpay_order_id"],
    razorpayPaymentId: json["razorpay_payment_id"],
    razorpaySignature: json["razorpay_signature"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_number": orderNumber,
    "customer_name": customerName,
    "customer_mobile": customerMobile,
    "customer_whatsapp": customerWhatsapp,
    "customer_address": customerAddress,
    "customer_zipcode": customerZipcode,
    "cart_id": cartId,
    "total_amount": totalAmount,
    "status": status,
    "payment_status": paymentStatus,
    "payment_method": paymentMethod,
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "notes": notes,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "razorpay_order_id": razorpayOrderId,
    "razorpay_payment_id": razorpayPaymentId,
    "razorpay_signature": razorpaySignature,
  };
}

class AllProduct {
  final int productId;
  final String productName;
  final num price;
  final int quantity;
  final num subtotal;
  final String imagePath;
  final String netWeight;

  AllProduct({
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.subtotal,
    required this.imagePath,
    required this.netWeight,
  });

  factory AllProduct.fromJson(Map<String, dynamic> json) => AllProduct(
    productId: json["product_id"] is String
        ? int.tryParse(json["product_id"]) ?? 0
        : json["product_id"] ?? 0,
    productName: json["product_name"] ?? '',
    price: num.tryParse(json["price"].toString()) ?? 0,
    quantity: json["quantity"] ?? 0,
    subtotal: num.tryParse(json["subtotal"].toString()) ?? 0,
    imagePath: json["image_path"] ?? '',
    netWeight: json["net_weight"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_name": productName,
    "price": price,
    "quantity": quantity,
    "subtotal": subtotal,
    "image_path": imagePath,
    "net_weight": netWeight,
  };
}
