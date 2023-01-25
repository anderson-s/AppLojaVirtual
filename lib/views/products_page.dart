import 'package:app_loja_virtual/controller/controller_product.dart';
import 'package:app_loja_virtual/models/utils/routes.dart';
import 'package:app_loja_virtual/views/components/app_drawer.dart';
import 'package:app_loja_virtual/views/components/product_item_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ControllerProduct products = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gerenciar Produtos"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.formProduct);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(
          8,
        ),
        child: ListView.builder(
          itemCount: products.itemsCount,
          itemBuilder: (ctx, index) {
            return Column(
              children: [
                ProductItemComponent(
                  product: products.returnProducts[index],
                ),
                const Divider()
              ],
            );
          },
        ),
      ),
    );
  }
}
