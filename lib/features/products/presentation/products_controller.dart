import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/product_repository.dart';
import '../data/product_repository_impl.dart';
import '../domaine/product_model.dart';
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
}
