import 'package:app_loja_virtual/views/products_overview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyWidget(),
  );
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = ThemeData();
    return MaterialApp(
      home: const ProductsOverView(),
      debugShowCheckedModeBanner: false,
      theme: tema.copyWith(),
    );
  }
}
