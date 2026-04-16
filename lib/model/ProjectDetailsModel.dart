class ProjectDetailsModel {
  final String name;
  final String description;
  final String image;
  final String lat;
  final String lng;
  final String salePrice;

  /// ✅ ADD THESE
  final String brochureDtl;
  final String layoutDtl;

  ProjectDetailsModel({
    required this.name,
    required this.description,
    required this.image,
    required this.lat,
    required this.lng,
    required this.brochureDtl,
    required this.layoutDtl,
    required this.salePrice,
  });

  factory ProjectDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProjectDetailsModel(
      name: json['project_name'] ?? "",
      description: json['description'] ?? "",
      image: json['menu_icon'] ?? "",
      lat: json['lat'] ?? "",
      lng: json['lan'] ?? "",
      salePrice: json['sale_price'] ?? 'N/A',

      /// ✅ MAP FROM API
      brochureDtl: json['brochure_dtl'] ?? "",
      layoutDtl: json['layout_dtl'] ?? "",
    );
  }

   
}
