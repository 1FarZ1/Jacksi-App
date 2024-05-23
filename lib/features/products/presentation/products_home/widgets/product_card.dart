import 'package:flutter/material.dart';
import 'package:sample_app/features/products/domaine/product_model.dart';
import 'package:sample_app/features/products/presentation/products_home/products_view.dart';

import 'custom_image.dart';
import '../../../../../utils/string_extension.dart';
import 'store_widget.dart';

class ListProductCard extends StatelessWidget {
  const ListProductCard(this.product, {super.key});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomImage(product: product),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(product.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              Text(product.price.toString().toDollarPrice()),
              StoreWidget(storeName: product.storeName),
            ],
          ),
        ],
      ),
    );
  }
}

class GridProductCard extends StatelessWidget {
  const GridProductCard(this.product, {super.key});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImage(product: product),
          const SizedBox(height: 8),
          Text(product.name,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(product.price.toString().toDollarPrice()),
          StoreWidget(storeName: product.storeName),
        ],
      ),
    );
  }
}
