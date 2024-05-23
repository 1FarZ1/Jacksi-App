import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_app/features/products/domaine/product_model.dart';
import 'package:sample_app/features/products/presentation/products_home/products_controller.dart';
import 'package:sample_app/features/products/presentation/products_home/products_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      // final products = sharedPreferences.getString('products');
    final products = [
      ProductModel(
        id: 1,
        name: 'منتج 1',
        price: 100,
        storeName: 'متجر 1',
        imageUrl:
            'https://images.unsplash.com/photo-1522517779552-6cf4c1f31ee3?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        categoryId: 1,
      ),
      ProductModel(
        id: 2,
        name: 'منتج 2',
        price: 200,
        storeName: 'متجر 2',
        imageUrl:
            'https://images.unsplash.com/photo-1515263487990-61b07816b324?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        categoryId: 2,
      ),
      ProductModel(
          id: 3,
          name: 'منتج 3',
          price: 300,
          storeName: 'متجر 3',
          imageUrl:
              'https://images.unsplash.com/photo-1548566862-2c9b1fed780a?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          categoryId: 3),
      ProductModel(
        id: 4,
        name: 'منتج 4',
        price: 400,
        storeName: 'متجر 4',
        imageUrl:
            'https://images.unsplash.com/photo-1495985812444-236d6a87bdd9?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        categoryId: 1,
      ),
    ];


  Future<List<ProductModel>> getProducts(int categoryId) async {

    // if (products != null) {
    //   // return ProductModel.fromJson(
    //   //   json.decode(products) as Map<String, dynamic>,
    //   // );
    //   [];
    // }
    if (categoryId != 0) {
      return products
          .where((element) => element.categoryId == categoryId)
          .toList();
    }
    return products;
  }

  Future<ProductModel> addProduct(AddProductModel addProductModel) async {
    // final products = sharedPreferences.getString('products');
    // final List<ProductModel> productsList;
    // productsList.add(productModel);
    // await sharedPreferences.setString('products', json.encode(productsList));
    final product = ProductModel(
      id: products.length + 1,
      name: addProductModel.name,
      price: addProductModel.price.toInt(),
      storeName: addProductModel.storeName,
      imageUrl: addProductModel.imageUrl,
      categoryId: addProductModel.categoryId,
    );

    products.add(product);

    return product;
  }
}
