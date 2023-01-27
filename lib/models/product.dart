import 'dart:convert';

import 'package:app_loja_virtual/models/exceptions/http_exception.dart';
import 'package:app_loja_virtual/models/services/contants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  get getId => id;

  set setId(id) => id = id;

  get getTitle => title;

  set setTitle(title) => title = title;

  get getDescription => description;

  set setDescription(description) => description = description;

  get getPrice => price;

  set setPrice(price) => price = price;

  get getImageUrl => imageUrl;

  set setImageUrl(imageUrl) => imageUrl = imageUrl;

  get getIsFavorite => isFavorite;

  set setIsFavorite(isFavorite) => isFavorite = isFavorite;

  void _togleIsFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> togleIsFavorite() async {
    try {
      _togleIsFavorite();

      final response = await http.patch(
          Uri.parse("${Constants.baseUrl}/produtos/$id.json"),
          body: jsonEncode({"isFavorite": isFavorite}));

      if (response.statusCode >= 400) {
        _togleIsFavorite();
      }
    } on HttpException catch (error) {
      throw HttpException(
          msg: "Não foi possível favoritar o produto.",
          statusCode: error.statusCode);
    }
  }
}
