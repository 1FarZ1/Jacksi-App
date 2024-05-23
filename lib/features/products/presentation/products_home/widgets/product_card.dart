import 'package:flutter/material.dart';
import 'package:sample_app/features/products/domaine/product_model.dart';

import 'custom_image.dart';
import 'price_widget.dart';
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
          SizedBox(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(product.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                PriceWidget(price: product.price),
                StoreWidget(storeName: product.storeName),
              ],
            ),
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
          PriceWidget(price: product.price),
          StoreWidget(storeName: product.storeName),
        ],
      ),
    );
  }
}
