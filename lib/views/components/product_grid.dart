import 'package:app_loja_virtual/controller/controller.dart';
import 'package:app_loja_virtual/models/product.dart';
import 'package:app_loja_virtual/views/components/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final bool optionFilters;
  const ProductGrid({super.key, required this.optionFilters});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Controller>(context, listen: false);
    final List<Product> loadProducts = optionFilters
        ? provider.returnProducts
            .where((element) => element.isFavorite)
            .toList()
        : provider.returnProducts;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: loadProducts[index],
          child: const ProductItem(),
        );
      },
    );
  }
}
