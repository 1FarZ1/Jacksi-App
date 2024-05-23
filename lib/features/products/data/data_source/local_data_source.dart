import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_app/features/products/domaine/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domaine/add_product_model.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(),
);

final localProductDataSourceProvider = Provider<LocalProductDataSoruce>(
  (ref) => LocalProductDataSoruce(
    sharedPreferences: ref.watch(sharedPreferencesProvider),
  ),
);

class LocalProductDataSoruce {
  final SharedPreferences sharedPreferences;

  LocalProductDataSoruce({required this.sharedPreferences});
  static const String _productsKey = 'products';

  Future<List<ProductModel>> getProducts(int categoryId) async {
    final productsString = sharedPreferences.getString(_productsKey);
    if (productsString != null) {
      final List<dynamic> jsonData = json.decode(productsString);
      final List<ProductModel> products = jsonData
          .map((productJson) => ProductModel.fromJson(productJson))
          .toList();

      if (categoryId != 0) {
        return products
            .where((element) => element.categoryId == categoryId)
            .toList();
      }
      return products;
    }
    return [];
  }

  // Future<void> seedData() async {
  //   final String productsJson = json.encode(products);
  //   await sharedPreferences.setString(_productsKey, productsJson);
  // }

  Future<void> saveProducts(List<ProductModel> products) async {
    final String productsJson = json.encode(products);
    await sharedPreferences.setString(_productsKey, productsJson);
  }

  Future<ProductModel> addProduct(AddProductModel addProductModel) async {
    final List<ProductModel> products = await getProducts(0);

    final product = ProductModel(
      id: products.length + 1,
      name: addProductModel.name,
      price: addProductModel.price.toInt(),
      storeName: addProductModel.storeName,
      imageUrl: addProductModel.imageUrl,
      categoryId: addProductModel.categoryId,
    );

    products.add(product);
    await saveProducts(products);

    return product;
  }
}
