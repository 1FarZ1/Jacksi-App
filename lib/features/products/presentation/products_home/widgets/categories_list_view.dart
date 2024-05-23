import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample_app/features/products/presentation/products_home/categories/categories_provider.dart';
import 'package:sample_app/features/products/presentation/products_home/widgets/category_card.dart';

class CategoriesListView extends ConsumerWidget {
  const CategoriesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ref.watch(categoriesProvider).length,
        itemBuilder: (context, index) {
          final category = ref.watch(categoriesProvider)[index];
          return CategoryCard(
            category: category,
            isSelected: ref.watch(currentCategoryProvider) == category.id,
            onTap: () {
              ref
                  .read(currentCategoryProvider.notifier)
                  .update((state) => category.id);
            },
          );
        },
      ),
    );
  }
}
