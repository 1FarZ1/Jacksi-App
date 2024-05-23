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
  // final products = [
  //   ProductModel(
  //     id: 1,
  //     name: 'منتج 1',
  //     price: 100,
  //     storeName: 'متجر 1',
  //     imageUrl:
  //         'https://images.unsplash.com/photo-1522517779552-6cf4c1f31ee3?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  //     categoryId: 1,
  //   ),
  //   ProductModel(
  //     id: 2,
  //     name: 'منتج 2',
  //     price: 200,
  //     storeName: 'متجر 2',
  //     imageUrl:
  //         'https://images.unsplash.com/photo-1515263487990-61b07816b324?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  //     categoryId: 2,
  //   ),
  //   ProductModel(
  //       id: 3,
  //       name: 'منتج 3',
  //       price: 300,
  //       storeName: 'متجر 3',
  //       imageUrl:
  //           'https://images.unsplash.com/photo-1548566862-2c9b1fed780a?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  //       categoryId: 3),
  //   ProductModel(
  //     id: 4,
  //     name: 'منتج 4',
  //     price: 400,
  //     storeName: 'متجر 4',
  //     imageUrl:
  //         'https://images.unsplash.com/photo-1495985812444-236d6a87bdd9?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  //     categoryId: 1,
  //   ),
  // ];

  Future<List<ProductModel>> getProducts(int categoryId) async {
    final productsString = sharedPreferences.getString(_productsKey);
    if (productsString != null) {
      final List<dynamic> jsonData = json.decode(productsString);
      log(jsonData.toString());
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
