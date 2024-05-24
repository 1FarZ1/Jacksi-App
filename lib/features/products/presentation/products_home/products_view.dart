import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample_app/common/async_value_widget.dart';
import 'package:sample_app/consts/app_colors.dart';

import '../../../../utils/enums.dart';
import '../add_product/add_product_view.dart';
import 'widgets/button_icon_widget.dart';
import 'widgets/categories_list_view.dart';
import 'widgets/change_view_widget.dart';
import 'widgets/custom_grid_view.dart';
import 'widgets/custom_list_view.dart';
import '../products_controller.dart';

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
          ButtonIconWidget(
            icon: 'assets/plus.svg',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddProductView(),
                ),
              );
            },
          )
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
                    style: TextStyle(color: AppColors.black, fontSize: 16)),
                const SizedBox(height: 8),
                const CategoriesListView(),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ChangeViewWidget(
                    viewStyle: viewStyle.value,
                    onTap: () {
                      viewStyle.value = viewStyle.value == ViewStyle.list
                          ? ViewStyle.grid
                          : ViewStyle.list;
                    },
                  ),
                ),
                AsyncValueWidget(
                    value: products,
                    data: (products) {
                      if (products.isEmpty) {
                        return const Center(
                          child: Text('لا يوجد منتجات حالياً'),
                        );
                      }

                      return viewStyle.value == ViewStyle.list
                          ? CustomListView(
                              products: products,
                            )
                          : CustomGridView(
                              products: products,
                            );
                    })
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
