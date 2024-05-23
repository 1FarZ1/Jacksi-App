

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_app/features/products/data/data_source/local_data_source.dart';
import 'package:sample_app/features/products/domaine/product_model.dart';

import '../domaine/add_product_model.dart';
import 'product_repository.dart';


final productRepositoryProvider = Provider<ProductRepository>(
  (ref) => ProductRepositoryImpl(
    localDataSource: ref.watch(localProductDataSourceProvider),
  ),
);

class ProductRepositoryImpl implements ProductRepository {
  final LocalProductDataSoruce localDataSource;

  ProductRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<List<ProductModel>> getProducts(int categoryId) async {
    return localDataSource.getProducts(categoryId);
  }

  @override
  Future<ProductModel> addProduct(AddProductModel addProductModel) async {
    return localDataSource.addProduct(addProductModel);
  }
}




