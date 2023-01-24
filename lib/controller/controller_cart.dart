import 'dart:math';

import 'package:app_loja_virtual/models/cart.dart';
import 'package:app_loja_virtual/models/product.dart';
import 'package:flutter/material.dart';

class ControllerCart with ChangeNotifier {
  final Map<String, Cart> _items = {};

  Map<String, Cart> get items {
    return {..._items};
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  double get totalAmount {
    double valorTotal = 0.0;
    _items.forEach((key, value) {
      valorTotal += value.price * value.quantify;
    });
    return valorTotal;
  }

  int get countItems {
    return _items.length;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (value) => Cart(
          id: value.id,
          productId: value.productId,
          title: value.title,
          quantify: value.quantify + 1,
          price: value.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => Cart(
          id: Random().nextDouble().toString(),
          productId: product.id,
          title: product.title,
          quantify: 1,
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
