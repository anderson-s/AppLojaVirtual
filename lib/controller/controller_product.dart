import 'dart:math';

import 'package:app_loja_virtual/models/data/products_data.dart';
import 'package:app_loja_virtual/models/product.dart';
import 'package:flutter/material.dart';

class ControllerProduct with ChangeNotifier {
  List<Product> _products = productsList;

  List<Product> get returnProducts {
    return [..._products];
  }

  void addProductFromData(Map<String, Object> data) {
    final newProduct = Product(
      id: Random().nextDouble().toString(),
      title: data["name"].toString(),
      description: data["description"].toString(),
      price: data["price"] as double,
      imageUrl: data["urlImage"].toString(),
    );
    _products.add(newProduct);
    notifyListeners();
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  int get itemsCount => _products.length;
}
