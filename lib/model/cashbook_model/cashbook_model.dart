class CashbookEntry {
  final String entryId;
  final String entryDate;
  final String entryType;
  final String amount;
  final String paymentMethod;
  final String referenceNo;
  final String description;
  final String attachment;

  CashbookEntry({
    required this.entryId,
    required this.entryDate,
    required this.entryType,
    required this.amount,
    required this.paymentMethod,
    required this.referenceNo,
    required this.description,
    required this.attachment,
  });

  factory CashbookEntry.fromJson(Map<String, dynamic> json) {
    return CashbookEntry(
      entryId: json['entry_id'],
      entryDate:
          (json['entry_date'] != null && json['entry_date'] != '0000-00-00'
              ? json['entry_date']
              : json['created_at']) ??
          '',
      entryType: json['entry_type'] ?? '',
      amount: json['amount'] ?? '0',
      paymentMethod: json['payment_method'] ?? '',
      referenceNo: json['reference_no'] ?? '',
      description: json['description'] ?? '',
      attachment: json['attachment'] ?? '',
    );
  }
}
