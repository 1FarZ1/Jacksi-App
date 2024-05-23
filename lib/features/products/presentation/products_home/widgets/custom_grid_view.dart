import 'package:flutter/material.dart';
import 'package:sample_app/features/products/domaine/product_model.dart';
import 'package:sample_app/features/products/presentation/products_home/widgets/product_card.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return GridProductCard(product);
      },
    );
  }
}
