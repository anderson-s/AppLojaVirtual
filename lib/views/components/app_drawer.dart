import 'package:app_loja_virtual/controller/controller_auth.dart';
import 'package:app_loja_virtual/models/utils/routes.dart';
import 'package:app_loja_virtual/views/auth_or_home_view.dart';
import 'package:app_loja_virtual/views/components/custom_route.dart';
import 'package:app_loja_virtual/views/orders_view.dart';
import 'package:app_loja_virtual/views/products_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("Bem vindo, Andeson!"),
            centerTitle: false,
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text("Loja"),
            onTap: () {
              // Navigator.pushReplacementNamed(context, Routes.authOrHome);
              Navigator.of(context).pushReplacement(
                CustomRoute(
                  builder: (ctx) => const AuthOrHomeView(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text("Pedidos"),
            onTap: () {
              // Navigator.pushReplacementNamed(context, Routes.orders,);
              Navigator.of(context).pushReplacement(
                CustomRoute(
                  builder: (ctx) => const OrdersView(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Gerenciar Produtos"),
            onTap: () {
              // Navigator.pushReplacementNamed(context, Routes.productsPage);
              Navigator.of(context).pushReplacement(
                CustomRoute(
                  builder: (ctx) => const ProductsPage(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Sair"),
            onTap: () {
              Provider.of<ControllerAuth>(context, listen: false).logout();
              Navigator.of(context).pushReplacementNamed(Routes.authOrHome);
            },
          ),
        ],
      ),
    );
  }
}
