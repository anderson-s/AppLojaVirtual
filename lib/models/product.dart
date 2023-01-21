import 'package:flutter/material.dart';

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

  void togleIsFavorite() {
    isFavorite = !isFavorite;

    notifyListeners();
  }
}
