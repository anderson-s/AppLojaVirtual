import 'package:app_loja_virtual/controller/controller_cart.dart';
import 'package:app_loja_virtual/controller/controller_order.dart';
import 'package:app_loja_virtual/controller/controller_product.dart';
import 'package:app_loja_virtual/models/utils/routes.dart';
import 'package:app_loja_virtual/views/cart_view.dart';
import 'package:app_loja_virtual/views/orders_view.dart';
import 'package:app_loja_virtual/views/product_detail.dart';
import 'package:app_loja_virtual/views/product_page_form.dart';
import 'package:app_loja_virtual/views/products_overview.dart';
import 'package:app_loja_virtual/views/products_page.dart';
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
          create: (_) => ControllerProduct(),
        ),
        ChangeNotifierProvider(
          create: (_) => ControllerCart(),
        ),
        ChangeNotifierProvider( 
          create: (_) => ControllerOrder(),
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
          Routes.home: (ctx) => const ProductsOverView(),
          Routes.detail: (ctx) => const ProductDetail(),
          Routes.cart: (ctx) => const CartView(),
          Routes.orders:(context) => const OrdersView(),
          Routes.productsPage:(context) => const ProductsPage(),
          Routes.formProduct:(context) => const ProductPageForm()
        },
      ),
    );
  }
}
