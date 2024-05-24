// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'product_model.g.dart';


@HiveType(typeId: 0)
class ProductModel extends HiveObject{
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String storeName;
  @HiveField(3)
  final int price;
  @HiveField(4)
  final List<String> imageUrl;
  @HiveField(5)
  final int categoryId;
  ProductModel({
    required this.id,
    required this.name,
    required this.storeName,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
  });

  ProductModel copyWith({
    int? id,
    String? name,
    String? storeName,
    int? price,
    List<String>? imageUrl,
    int? categoryId,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      storeName: storeName ?? this.storeName,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'storeName': storeName,
      'price': price,
      'imageUrl': imageUrl,
      'categoryId': categoryId,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      name: map['name'] as String,
      storeName: map['storeName'] as String,
      price: map['price'] as int,
      imageUrl: List<String>.from(
        (map['imageUrl'] as List),
      ),
      categoryId: map['categoryId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, storeName: $storeName, price: $price, imageUrl: $imageUrl, categoryId: $categoryId)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.storeName == storeName &&
        other.price == price &&
        listEquals(other.imageUrl, imageUrl) &&
        other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        storeName.hashCode ^
        price.hashCode ^
        imageUrl.hashCode ^
        categoryId.hashCode;
  }
}
