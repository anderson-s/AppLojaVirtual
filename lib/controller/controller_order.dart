import 'dart:math';

import 'package:app_loja_virtual/controller/controller_cart.dart';
import 'package:app_loja_virtual/models/order.dart';
import 'package:flutter/material.dart';

class ControllerOrder with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items => [..._items];

  int get itemsCount => _items.length;

  void addOrder(ControllerCart cart) {
    _items.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        data: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
