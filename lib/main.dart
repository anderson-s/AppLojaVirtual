import 'package:app_loja_virtual/controller/controller.dart';
import 'package:app_loja_virtual/models/utils/routes.dart';
import 'package:app_loja_virtual/views/product_detail.dart';
import 'package:app_loja_virtual/views/products_overview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Controller(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: tema.copyWith(
          colorScheme: tema.colorScheme.copyWith(
            primary: Colors.purple,
            secondary: Colors.deepOrange,
          ),
          appBarTheme: tema.appBarTheme.copyWith(
            titleTextStyle: const TextStyle(
              fontFamily: "Lato",
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        routes: {
          Routes.home: (context) => const ProductsOverView(),
          Routes.detail: (context) => const ProductDetail(),
        },
      ),
    );
  }
}
