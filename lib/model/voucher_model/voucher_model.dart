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
  String? status; // raw status from API
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
      itemsList = List<Map<String, dynamic>>.from(json['items_json'])
          .map((item) => VoucherItem.fromJson(item))
          .toList();
    }

    return Voucher(
      voucherId: json['voucher_id'].toString(),
      voucherDate: json['voucher_date'] ?? '',
      voucherType: json['voucher_type'] ?? '',
      voucherNo: json['voucher_no'],
      billTo: json['bill_to'],
      amount: json['amount'].toString(),
      description: json['description'],
      paymentMode: json['payment_mode'],
      referenceNo: json['reference_no'],
      referenceDoc: json['reference_doc'],
      status: json['status']?.toString(), // always keep as string
      approvedBy: json['approved_by']?.toString(),
      approvedAt: json['approved_at'],
      createdBy: json['created_by']?.toString(),
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

  /// Human-readable status
  String get statusText {
    switch (status) {
      case '1':
        return 'Pending';
      case '2':
        return 'Approved';
      case '3':
        return 'Rejected';
      default:
        return 'Pending';
    }
  }
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
      item: json['item'] ?? json['item_name'], // handle both possible keys
      itemId: json['item_id'],
      description: json['description'],
      qty: json['qty'] is int
          ? json['qty']
          : int.tryParse(json['qty']?.toString() ?? '1') ?? 1,
      rate: json['rate'] != null
          ? double.tryParse(json['rate'].toString()) ?? 0
          : json['unit_price'] != null
          ? double.tryParse(json['unit_price'].toString()) ?? 0
          : 0,
      price: json['price'] != null
          ? double.tryParse(json['price'].toString())
          : null,
      total: json['total'] != null
          ? double.tryParse(json['total'].toString())
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
