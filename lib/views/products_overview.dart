import 'package:app_loja_virtual/views/components/product_grid.dart';
import 'package:flutter/material.dart';

class ProductsOverView extends StatefulWidget {
  const ProductsOverView({super.key});

  @override
  State<ProductsOverView> createState() => _ProductsOverViewState();
}

class _ProductsOverViewState extends State<ProductsOverView> {
  bool optionsFilters = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Minha Loja"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) {
              return [
                const PopupMenuItem(
                  value: true,
                  child: Text("Somente Favoritos"),
                ),
                const PopupMenuItem(
                  value: false,
                  child: Text("Todos"),
                ),
              ];
            },
            onSelected: (value) {
              setState(() {
                optionsFilters = value;
              });
            },
          )
        ],
      ),
      body: ProductGrid(optionFilters: optionsFilters),
    );
  }
}
