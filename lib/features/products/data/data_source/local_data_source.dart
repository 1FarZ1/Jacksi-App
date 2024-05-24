import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sample_app/features/products/domaine/product/product_model.dart';

import '../../domaine/add_product_model.dart';

// final sharedPreferencesProvider = Provider<SharedPreferences>(
//   (ref) => throw UnimplementedError(),
// );

final hiveProvider = Provider<Box<ProductModel>>((ref) {
  throw UnimplementedError();
});

final localProductDataSourceProvider = Provider<LocalProductDataSoruce>(
  (ref) => LocalProductDataSoruce(
    ref.watch(hiveProvider),
  ),
);

class LocalProductDataSoruce {
  final Box<ProductModel> _productsBox;

  LocalProductDataSoruce(this._productsBox);

  Future<List<ProductModel>> getAllProducts() async {
    final List<ProductModel> products = _productsBox.values.toList();
    return products;
  }

  Future<List<ProductModel>> getProductsbyCategory(int categoryId) async {
    final List<ProductModel> products = _productsBox.values
        .where((element) => element.categoryId == categoryId)
        .toList();
    return products;
  }

  Future<ProductModel> addProduct(AddProductModel product) async {
    final ProductModel productModel = ProductModel(
      id: _productsBox.values.length + 1,
      name: product.name,
      storeName: product.storeName,
      price: product.price,
      imageUrl: product.imageUrl,
      categoryId: product.categoryId,
    );
    await _productsBox.add(productModel);
    return productModel;
  }
}


