class AddProductModel {
  final String name;
  final double price;
  final String storeName;
  final List<String> imageUrl;
  final int categoryId;

  AddProductModel({
    required this.name,
    required this.price,
    required this.storeName,
    required this.imageUrl,
    required this.categoryId,
  });
}
