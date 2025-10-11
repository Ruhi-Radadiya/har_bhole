class Voucher {
  String voucherId;
  String voucherDate;
  String voucherType;
  String? voucherNo;
  String? billTo;
  String amount;
  String? description;
  String? paymentMode;
  String? referenceNo;
  String? referenceDoc;
  String? status;
  String? approvedBy;
  String? approvedAt;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  String? voucherCode;
  String? bankName;
  String? accountNumber;
  String? transactionNumber;
  List<VoucherItem> items;

  Voucher({
    required this.voucherId,
    required this.voucherDate,
    required this.voucherType,
    this.voucherNo,
    this.billTo,
    required this.amount,
    this.description,
    this.paymentMode,
    this.referenceNo,
    this.referenceDoc,
    this.status,
    this.approvedBy,
    this.approvedAt,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.voucherCode,
    this.bankName,
    this.accountNumber,
    this.transactionNumber,
    required this.items,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    var itemsList = <VoucherItem>[];
    if (json['items_json'] != null) {
      itemsList = List<Map<String, dynamic>>.from(
        json['items_json'],
      ).map((item) => VoucherItem.fromJson(item)).toList();
    }

    return Voucher(
      voucherId: json['voucher_id'],
      voucherDate: json['voucher_date'],
      voucherType: json['voucher_type'],
      voucherNo: json['voucher_no'],
      billTo: json['bill_to'],
      amount: json['amount'],
      description: json['description'],
      paymentMode: json['payment_mode'],
      referenceNo: json['reference_no'],
      referenceDoc: json['reference_doc'],
      status: json['status'],
      approvedBy: json['approved_by'],
      approvedAt: json['approved_at'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      voucherCode: json['voucher_code'],
      bankName: json['bank_name'],
      accountNumber: json['account_number'],
      transactionNumber: json['transaction_number'],
      items: itemsList,
    );
  }

  Map<String, dynamic> toJson() => {
    'voucher_id': voucherId,
    'voucher_date': voucherDate,
    'voucher_type': voucherType,
    'voucher_no': voucherNo,
    'bill_to': billTo,
    'amount': amount,
    'description': description,
    'payment_mode': paymentMode,
    'reference_no': referenceNo,
    'reference_doc': referenceDoc,
    'status': status,
    'approved_by': approvedBy,
    'approved_at': approvedAt,
    'created_by': createdBy,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'voucher_code': voucherCode,
    'bank_name': bankName,
    'account_number': accountNumber,
    'transaction_number': transactionNumber,
    'items_json': items.map((e) => e.toJson()).toList(),
  };
}

class VoucherItem {
  String? item;
  int? itemId;
  String? description;
  int qty;
  double rate;
  double? price;
  double? total;

  VoucherItem({
    this.item,
    this.itemId,
    this.description,
    required this.qty,
    this.rate = 0,
    this.price,
    this.total,
  });

  factory VoucherItem.fromJson(Map<String, dynamic> json) {
    return VoucherItem(
      item: json['item'],
      itemId: json['item_id'],
      description: json['description'],
      qty: json['qty'] is int ? json['qty'] : int.parse(json['qty'].toString()),
      rate: json['rate'] != null ? double.parse(json['rate'].toString()) : 0,
      price: json['price'] != null
          ? double.parse(json['price'].toString())
          : null,
      total: json['total'] != null
          ? double.parse(json['total'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'item': item,
    'item_id': itemId,
    'description': description,
    'qty': qty,
    'rate': rate,
    'price': price,
    'total': total,
  };
}
