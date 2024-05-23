import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/product_repository.dart';
import '../../data/product_repository_impl.dart';
import '../../domaine/product_model.dart';
import '../../domaine/add_product_model.dart';
import 'categories/categories_provider.dart';

final productsControllerProvider =
    StateNotifierProvider<ProductsController, AsyncValue<List<ProductModel>>>(
  (ref) {
    final categoryId = ref.watch(currentCategoryProvider);
    return ProductsController(
      productRepository: ref.watch(productRepositoryProvider),
      categoryId: categoryId,
    );
  },
);

class ProductsController extends StateNotifier<AsyncValue<List<ProductModel>>> {
  final ProductRepository productRepository;
  final int categoryId;

  ProductsController({
    required this.productRepository,
    this.categoryId = 0,
  }) : super(
          const AsyncValue.loading(),
        ) {
    getProducts();
  }

  Future<void> getProducts() async {
    state = const AsyncValue.loading();
    try {
      final products = await productRepository.getProducts(categoryId);
      state = AsyncValue.data(products);
    } catch (e, st) {
      log(e.toString());
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addProduct(
    AddProductModel addProductModel,
  ) async {
    state = const AsyncValue.loading();
    try {
      final product = await productRepository.addProduct(addProductModel);

      // [this can be done also]
      // if (addProductModel.categoryId == categoryId) {
      //   state = AsyncValue.data([...state.asData!.value, product]);
      // } else {
      //   state = AsyncValue.data([...state.asData!.value]);
      // }
      getProducts();
    } catch (e, st) {
      log(e.toString());
      state = AsyncValue.error(e, st);
    }
  }
}
