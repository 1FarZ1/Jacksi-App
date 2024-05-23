import 'package:flutter/material.dart';
import 'package:sample_app/features/products/domaine/product_model.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(product.imageUrl.isEmpty || product.imageUrl[0].isEmpty
                  ? 'https://via.placeholder.com/150'
                  : product.imageUrl[0]),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(8)),
    );
  }
}
