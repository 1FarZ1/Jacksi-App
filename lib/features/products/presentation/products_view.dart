import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample_app/consts/app_colors.dart';

import 'add_product_view.dart';
import 'category_card.dart';
import 'widgets/change_view_widget.dart';
import 'widgets/custom_grid_view.dart';
import 'widgets/custom_list_view.dart';
import 'products_controller.dart';

class Category {
  final int id;
  final String name;
  final String imageUrl;

  const Category(
      {required this.id, required this.name, required this.imageUrl});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category && other.id == id;
  }
}

enum CategoryType {
  all,
  electronics,
  clothing,
  shoes,
}

final currentCategoryProvider = StateProvider<int>((ref) => 0);

final categoriesProvider = Provider<List<Category>>((ref) {
  const thirdimage =
      'https://images.unsplash.com/photo-1429087969512-1e85aab2683d?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
  return [
    const Category(
      id: 1,
      name: ' تصنيف 1',
      imageUrl:
          'https://images.unsplash.com/photo-1527195612250-460488c1ad32?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    const Category(
      id: 2,
      name: 'تصنيف 2',
      imageUrl:
          'https://images.unsplash.com/photo-1518972734183-c5b490a7c637?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    const Category(
      id: 3,
      name: 'تصنيف 3',
      imageUrl: thirdimage,
    ),
  ];
});

enum ViewStyle {
  list,
  grid,
}

class ProductsView extends HookConsumerWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsControllerProvider);
    final viewStyle = useState<ViewStyle>(ViewStyle.list);
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar:
            AppBar(title: const Text('المنتجات'), centerTitle: true, actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddProductView(),
                ),
              );
            },
          ),
        ]),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('التصنيفات',
                    style: TextStyle(color: AppColors.grey, fontSize: 16)),
                // horezental list view of categories
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: ref.watch(categoriesProvider).length,
                    itemBuilder: (context, index) {
                      final category = ref.watch(categoriesProvider)[index];
                      return CategoryCard(
                        category: category,
                        isSelected:
                            ref.watch(currentCategoryProvider) == category.id,
                        onTap: () {
                          ref
                              .read(currentCategoryProvider.notifier)
                              .update((state) => category.id);
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),

                Align(
                  alignment: Alignment.centerLeft,
                  child: ChangeViewWidget(
                    viewStyle: viewStyle.value,
                    onTap: () {
                      log('viewStyle.value: ${viewStyle.value}');
                      viewStyle.value = viewStyle.value == ViewStyle.list
                          ? ViewStyle.grid
                          : ViewStyle.list;
                    },
                  ),
                ),

                products.when(
                  data: (products) {
                    return viewStyle.value == ViewStyle.list
                        ? CustomListView(
                            products: products,
                          )
                        : CustomGridView(
                            products: products,
                          );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('An error occurred'),
                        ElevatedButton(
                          onPressed: () {
                            ref
                                .read(productsControllerProvider.notifier)
                                .getProducts();
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class ShowAllWidget extends StatelessWidget {
  const ShowAllWidget(
      {super.key, required this.onTap, required this.isPressed});
  final VoidCallback onTap;
  final bool isPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border:
              Border.all(color: isPressed ? AppColors.white : AppColors.green),
        ),
        child: const Text(
          'عرض الكل',
          style: TextStyle(color: AppColors.white, fontSize: 12),
        ),
      ),
    );
  }
}
