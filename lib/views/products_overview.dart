import 'package:flutter/material.dart';

class ProductsOverView extends StatefulWidget {
  const ProductsOverView({super.key});

  @override
  State<ProductsOverView> createState() => _ProductsOverViewState();
}

class _ProductsOverViewState extends State<ProductsOverView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Produtos"),
      ),
    );
  }
}
