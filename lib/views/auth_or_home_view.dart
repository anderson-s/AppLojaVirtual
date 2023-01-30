import 'package:app_loja_virtual/controller/controller_auth.dart';
import 'package:app_loja_virtual/views/auth_view.dart';
import 'package:app_loja_virtual/views/products_overview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthOrHomeView extends StatelessWidget {
  const AuthOrHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<ControllerAuth>(context);

    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (ctx, snapshot) {
        if (snapshot.error != null) {
          return const Center(
            child: Text("Ocorreu um erro!"),
          );
        } else {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              return auth.isAuth ? const ProductsOverView() : const AuthView();
          }
        }
      },
    );
  }
}
