class BannerModel {
  final String id;
  final String title;
  final String festival;
  final String imageUrl;

  BannerModel({
    required this.id,
    required this.title,
    required this.festival,
    required this.imageUrl,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      festival: json['festival'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }
}
