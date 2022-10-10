class TvCategory {
  final String categoryId;
  final String categoryName;

  TvCategory({
    required this.categoryId,
    required this.categoryName,
  });

  factory TvCategory.fromJson(Map<String, dynamic> json) => TvCategory(
        categoryId: json['category_id'],
        categoryName: json['category_name'],
      );

  Map<String, dynamic> toJson() => {
        'category_id': categoryId,
        'category_name': categoryName,
      };
}
