class PremiumCollectionModel {
  final String categoryId;
  final String categoryName;
  final String categoryCode;
  final String description;
  final String? parentId;
  final String status;
  final String sortOrder;
  final String categoryImage;
  final String createdAt;
  final String updatedAt;
  final String showOnHome;

  PremiumCollectionModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryCode,
    required this.description,
    this.parentId,
    required this.status,
    required this.sortOrder,
    required this.categoryImage,
    required this.createdAt,
    required this.updatedAt,
    required this.showOnHome,
  });

  factory PremiumCollectionModel.fromJson(Map<String, dynamic> json) {
    return PremiumCollectionModel(
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      categoryCode: json['category_code'],
      description: json['description'],
      parentId: json['parent_id'],
      status: json['status'],
      sortOrder: json['sort_order'],
      categoryImage: json['category_image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      showOnHome: json['show_on_home'],
    );
  }
}
