


// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sample_app/features/products/data/product_repository_impl.dart';

// import '../../data/product_repository.dart';

// final addProductController = StateNotifierProvider.autoDispose<AddProductController, AsyncValue<void>>(
//   (ref) => AddProductController(ref.watch(productRepositoryProvider)),
// );


// class AddProductController extends StateNotifier<AsyncValue<void>> {
//   final ProductRepository productRepository;

//   AddProductController(this.productRepository) : super(const AsyncValue.loading());

//   Future<void> addProduct() async {
//     state = const AsyncValue.loading();
//     try {
//       await productRepository.addProduct();
//       state = const AsyncValue.data(null);
//     } catch (e, st) {
//       state = AsyncValue.error(e, st);
//     }
//   }
// }