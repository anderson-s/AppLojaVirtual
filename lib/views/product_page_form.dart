import 'package:flutter/material.dart';

class ProductPageForm extends StatefulWidget {
  const ProductPageForm({super.key});

  @override
  State<ProductPageForm> createState() => _ProductPageFormState();
}

class _ProductPageFormState extends State<ProductPageForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulário de Produto"),
        centerTitle: true,
      ),
    );
  }
}
