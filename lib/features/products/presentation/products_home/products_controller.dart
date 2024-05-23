import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/product_repository.dart';
import '../../data/product_repository_impl.dart';
import '../../domaine/product_model.dart';
import 'products_view.dart';

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
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addProduct(
    AddProductModel addProductModel,
  ) async {
    state = const AsyncValue.loading();
    try {
      final product = await productRepository.addProduct(addProductModel);

      
      // if (addProductModel.categoryId == categoryId){
      //   state = AsyncValue.data([...state.value!,product]);
      // }
      // else{
      //   state = AsyncValue.data([...state.value!]);
      // }
      getProducts();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

class AddProductModel {
  final String name;
  final double price;
  final String storeName;
  final String imageUrl;
  final int categoryId;

  AddProductModel({
    required this.name,
    required this.price,
    required this.storeName,
    required this.imageUrl,
    required this.categoryId,
  });
}
