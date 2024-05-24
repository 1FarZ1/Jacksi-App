import 'package:flutter/material.dart';
import 'package:sample_app/features/products/domaine/product/product_model.dart';
import 'package:sample_app/features/products/presentation/products_home/widgets/product_card.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ListProductCard(product);
      },
    );
  }
}
