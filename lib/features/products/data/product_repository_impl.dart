

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_app/features/products/data/data_source/local_data_source.dart';
import 'package:sample_app/features/products/domaine/product/product_model.dart';

import '../domaine/add_product_model.dart';
import 'product_repository.dart';


final productRepositoryProvider = Provider<ProductRepository>(
  (ref) => LocalProductRepository(
    localDataSource: ref.watch(localProductDataSourceProvider),
  ),
);

class LocalProductRepository implements ProductRepository {
  final LocalProductDataSoruce localDataSource;

  LocalProductRepository({
    required this.localDataSource,
  });

  @override
  Future<List<ProductModel>> getAllProducts() async {
    return await localDataSource.getAllProducts();
  }

  @override
  Future<List<ProductModel>> getProductsbyCategory(int categoryId) async {
    return  await localDataSource.getProductsbyCategory(categoryId);
  }

  @override
  Future<ProductModel> addProduct(AddProductModel addProductModel) async {
    return await localDataSource.addProduct(addProductModel);
  }
}




