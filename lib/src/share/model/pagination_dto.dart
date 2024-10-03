class PaginationDto {
  int page;
  int offset;

  PaginationDto({
    required this.page,
    required this.offset,
  });

  Map<String, dynamic> toJson() => {'page': page, 'per_page': offset};
}
