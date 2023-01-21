import 'package:app_loja_virtual/views/components/product_grid.dart';

import 'package:flutter/material.dart';

class ProductsOverView extends StatelessWidget {
  const ProductsOverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Minha Loja"),
        centerTitle: true,
      ),
      body: const ProductGrid(),
    );
  }
}
