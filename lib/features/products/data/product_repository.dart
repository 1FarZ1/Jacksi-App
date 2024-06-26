


import 'package:sample_app/features/products/domaine/product/product_model.dart';

import '../domaine/add_product_model.dart';




abstract class ProductRepository {
  Future<List<ProductModel>> getAllProducts();
  Future<List<ProductModel>> getProductsbyCategory(int categoryId);
  Future<ProductModel> addProduct(AddProductModel addProductModel);
}





