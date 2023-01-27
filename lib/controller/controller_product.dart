import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:app_loja_virtual/models/product.dart';
import 'package:flutter/material.dart';

class ControllerProduct with ChangeNotifier {
  final baseUrl =
      "https://minhalojavirtual-5d19d-default-rtdb.asia-southeast1.firebasedatabase.app/";
  final List<Product> _products = [];

  Future<void> loadProducts() async {
    _products.clear();
    final response = await http.get(Uri.parse("$baseUrl/produtos.json"));
    if (jsonDecode(response.body) != null) {
      Map<String, dynamic> data = jsonDecode(response.body);

      data.forEach((key, value) {
        _products.add(
          Product(
            id: key,
            title: value["name"],
            description: value["description"],
            price: value["price"],
            imageUrl: value["imageUrl"],
            isFavorite: value["isFavorite"],
          ),
        );
        notifyListeners();
      });
    } else {
      return;
    }
  }

  List<Product> get returnProducts {
    return [..._products];
  }

  Future<void> saveProductFromData(Map<String, Object> data) {
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

  Future<void> addProduct(Product product) async {
    final future = await http.post(
      Uri.parse("$baseUrl/produtos.json"),
      body: jsonEncode(
        {
          "name": product.getTitle,
          "description": product.getDescription,
          "price": product.getPrice,
          "imageUrl": product.getImageUrl,
          "isFavorite": product.getIsFavorite,
        },
      ),
    );
    final id = jsonDecode(future.body)["name"];
    _products.add(
      Product(
        id: id,
        title: product.getTitle,
        description: product.getDescription,
        price: product.getPrice,
        imageUrl: product.getImageUrl,
        isFavorite: product.getIsFavorite,
      ),
    );
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
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
