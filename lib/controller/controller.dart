import 'package:app_loja_virtual/models/data/products_data.dart';
import 'package:app_loja_virtual/models/product.dart';
import 'package:flutter/material.dart';

class Controller with ChangeNotifier {
  List<Product> _products = productsList;

  List<Product> get returnProducts {
    return [..._products];
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }
}
