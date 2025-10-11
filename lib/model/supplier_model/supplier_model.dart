class Supplier {
  final String supplierId;
  final String? supplierCode;
  final String supplierName;
  final String contactPerson;
  final String phone;
  final String email;
  final String? website;
  final String address;
  final String city;
  final String state;
  final String pinCode;
  final String country;
  final String? gstNumber;
  final String? panNumber;
  final String paymentTerms;
  final String creditLimit;
  final String notes;
  final String status;
  final String createdBy;

  Supplier({
    required this.supplierId,
    this.supplierCode,
    required this.supplierName,
    required this.contactPerson,
    required this.phone,
    required this.email,
    this.website,
    required this.address,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.country,
    this.gstNumber,
    this.panNumber,
    required this.paymentTerms,
    required this.creditLimit,
    required this.notes,
    required this.status,
    required this.createdBy,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      supplierId: json['supplier_id'].toString(),
      supplierCode: json['supplier_code'],
      supplierName: json['supplier_name'] ?? '-',
      contactPerson: json['contact_person'] ?? '-',
      phone: json['phone'] ?? '-',
      email: json['email'] ?? '-',
      website: json['website'],
      address: json['address'] ?? '-',
      city: json['city'] ?? '-',
      state: json['state'] ?? '-',
      pinCode: json['pin_code'] ?? '-',
      country: json['country'] ?? '-',
      gstNumber: json['gst_number'],
      panNumber: json['pan_number'],
      paymentTerms: json['payment_terms'] ?? '-',
      creditLimit: json['credit_limit'] ?? '0',
      notes: json['notes'] ?? '',
      status: json['status'] ?? '-',
      createdBy: json['created_by'] ?? '-',
    );
  }
}
