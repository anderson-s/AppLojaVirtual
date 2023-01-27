import 'package:app_loja_virtual/controller/controller_cart.dart';
import 'package:app_loja_virtual/controller/controller_product.dart';
import 'package:app_loja_virtual/views/components/app_drawer.dart';
import 'package:app_loja_virtual/views/components/badge.dart';
import 'package:app_loja_virtual/views/components/product_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsOverView extends StatefulWidget {
  const ProductsOverView({super.key});

  @override
  State<ProductsOverView> createState() => _ProductsOverViewState();
}

class _ProductsOverViewState extends State<ProductsOverView> {
  bool optionsFilters = false;
  bool progresso = true;
  @override
  void initState() {
    Provider.of<ControllerProduct>(context, listen: false)
        .loadProducts()
        .then((value) {
      setState(() {
        progresso = false;
      });
    });
    super.initState();
  }

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
          ),
          Consumer<ControllerCart>(
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/cart");
              },
              icon: const Icon(
                Icons.shopping_cart,
              ),
            ),
            builder: (ctx, value, child) {
              return Badge(
                value: value.countItems.toString(),
                child: child!,
              );
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: progresso
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductGridItem(
              optionFilters: optionsFilters,
            ),
    );
  }
}
