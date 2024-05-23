class Category {
  final int id;
  final String name;
  final String imageUrl;

  const Category(
      {required this.id, required this.name, required this.imageUrl});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category && other.id == id;
  }
}
