import 'dart:math';

import 'package:app_loja_virtual/models/data/products_data.dart';
import 'package:app_loja_virtual/models/product.dart';
import 'package:flutter/material.dart';

class ControllerProduct with ChangeNotifier {
  final List<Product> _products = productsList;

  List<Product> get returnProducts {
    return [..._products];
  }

  void saveProductFromData(Map<String, Object> data) {
    final hasId = data["id"] != null;

    final product = Product(
      id: hasId ? data["id"].toString() : Random().nextDouble().toString(),
      title: data["name"].toString(),
      description: data["description"].toString(),
      price: data["price"] as double,
      imageUrl: data["urlImage"].toString(),
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    int index =
        _products.indexWhere((element) => element.getId == product.getId);

    if (index >= 0) {
      _products[index] = product;
      notifyListeners();
    }
  }

  int get itemsCount => _products.length;
}
