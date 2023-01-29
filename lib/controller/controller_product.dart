import 'dart:convert';
import 'dart:math';
import 'package:app_loja_virtual/models/exceptions/http_exception.dart';
import 'package:app_loja_virtual/models/services/contants.dart';
import 'package:http/http.dart' as http;
import 'package:app_loja_virtual/models/product.dart';
import 'package:flutter/material.dart';

class ControllerProduct with ChangeNotifier {
  final List<Product> _products;
  final String _token;

  ControllerProduct(this._token, this._products);

  Future<void> loadProducts() async {
    _products.clear();
    final response =
        await http.get(Uri.parse("${Constants.baseUrl}.json?auth=$_token"));
    if (response.body != "null") {
      Map<String, dynamic> data = jsonDecode(response.body);

      data.forEach((key, value) {
        _products.add(
          Product(
            id: key,
            title: value["name"].toString(),
            description: value["description"].toString(),
            price: double.tryParse(value["price"].toString()) ?? 0.0,
            imageUrl: value["imageUrl"].toString(),
            isFavorite: value["isFavorite"] as bool,
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
      isFavorite: hasId ? data["isFavorite"] as bool : false,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Product product) async {
    final future = await http.post(
      Uri.parse("${Constants.baseUrl}.json?auth=$_token"),
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
      await http.patch(
          Uri.parse("${Constants.baseUrl}/${product.getId}.json?auth=$_token"),
          body: jsonEncode(
            {
              "name": product.getTitle,
              "description": product.getDescription,
              "price": product.getPrice,
              "imageUrl": product.getImageUrl,
            },
          ));

      _products[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(Product product) async {
    int index =
        _products.indexWhere((element) => element.getId == product.getId);
    if (index >= 0) {
      final p = _products[index];
      _products.removeAt(index);
      notifyListeners();
      final response = await http.delete(
          Uri.parse("${Constants.baseUrl}/${product.getId}.json?auth=$_token"));

      if (response.statusCode >= 400) {
        _products.insert(index, p);
        notifyListeners();
        throw HttpException(
          msg: "Não foi possível excluir o produto.",
          statusCode: response.statusCode,
        );
      }
    }
  }

  int get itemsCount => _products.length;
}
