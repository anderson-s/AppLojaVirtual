import 'package:app_loja_virtual/controller/controller_auth.dart';
import 'package:app_loja_virtual/views/auth_view.dart';
import 'package:app_loja_virtual/views/products_overview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthOrHomeView extends StatelessWidget {
  const AuthOrHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<ControllerAuth>(context).isAuth;
    return auth ? const ProductsOverView() : const AuthView();
  }
}
