class CategoryModel {
  final int id;
  final int rank;
  final String title;
  final String slug;
  final String icon;

  CategoryModel({
    required this.id,
    required this.rank,
    required this.title,
    required this.slug,
    required this.icon,
  });

  factory CategoryModel.fromJson(final Map<String, dynamic> json) =>
      CategoryModel(
        id: json['id'],
        rank: json['rank'],
        title: json['title'],
        slug: json['slug'],
        icon: json['icon'],
      );

  CategoryModel copyWith({
    final int? id,
    final int? rank,
    final String? title,
    final String? slug,
    final String? icon,
  }) =>
      CategoryModel(
        id: id ?? this.id,
        rank: rank ?? this.rank,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        icon: icon ?? this.icon,
      );
}
