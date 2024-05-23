import 'dart:io';

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
              image: product.imageUrl.isEmpty || product.imageUrl[0].isEmpty
                  ? const NetworkImage(
                      'https://www.thermaxglobal.com/wp-content/uploads/2020/05/image-not-found.jpg')
                  : FileImage(File(product.imageUrl[0])) as ImageProvider<Object>
                  ,),
          borderRadius: BorderRadius.circular(8)),
    );
  }
}
