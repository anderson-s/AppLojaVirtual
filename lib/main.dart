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
        // textTheme: tema.textTheme.copyWith(
        //   headline6: const TextStyle(
        //     fontFamily: "Anton",
        //     fontSize: 18,
        //     color: Colors.white,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
      ),
    );
  }
}
