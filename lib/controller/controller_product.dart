import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:app_loja_virtual/models/data/products_data.dart';
import 'package:app_loja_virtual/models/product.dart';
import 'package:flutter/material.dart';

class ControllerProduct with ChangeNotifier {
  final baseUrl =
      "https://minhalojavirtual-5d19d-default-rtdb.asia-southeast1.firebasedatabase.app/";
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
    http.post(
      Uri.parse("$baseUrl/produtos.json"),
      body: jsonEncode(
        {
          "name": product.getTitle,
          "description": product.getDescription,
          "price": product.getPrice,
          "imageUrl": product.getImageUrl,
        },
      ),
    );
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

  deleteProduct(Product product) {
    int index =
        _products.indexWhere((element) => element.getId == product.getId);
    if (index >= 0) {
      _products.removeAt(index);
      notifyListeners();
    }
  }

  int get itemsCount => _products.length;
}
