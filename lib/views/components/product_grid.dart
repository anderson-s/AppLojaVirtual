import 'package:app_loja_virtual/controller/controller.dart';
import 'package:app_loja_virtual/models/product.dart';
import 'package:app_loja_virtual/views/components/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> loadProducts =
        Provider.of<Controller>(context, listen: false).returnProducts;
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
        return ChangeNotifierProvider(
          create: (_) => loadProducts[index],
          child: const ProductItem(),
        );
      },
    );
  }
}
