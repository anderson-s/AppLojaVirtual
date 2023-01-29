import 'dart:convert';
import 'package:app_loja_virtual/models/cart.dart';
import 'package:app_loja_virtual/models/services/contants.dart';
import 'package:http/http.dart' as http;
import 'package:app_loja_virtual/controller/controller_cart.dart';
import 'package:app_loja_virtual/models/order.dart';
import 'package:flutter/material.dart';

class ControllerOrder with ChangeNotifier {
  List<Order> _items;
  final String _token;
  ControllerOrder(this._token, this._items);

  List<Order> get items => [..._items];

  int get itemsCount => _items.length;

  Future<void> loadOrder() async {
    List<Order> items = [];
    final response =
        await http.get(Uri.parse("${Constants.pedidos}.json?auth=$_token"));
    if (response.body == "null") {
      return;
    }
    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach(
      (key, value) {
        items.add(
          Order(
            id: key,
            data: DateTime.parse(value["data"]),
            total: value["total"],
            products: (value["products"] as List<dynamic>)
                .map(
                  (e) => Cart(
                    id: e["id"],
                    productId: e["productId"],
                    title: e["productTitle"],
                    quantify: e["quantify"],
                    price: e["price"],
                  ),
                )
                .toList(),
          ),
        );
      },
    );
    _items = items.reversed.toList();
  }

  Future<void> addOrder(ControllerCart cart) async {
    final data = DateTime.now();
    final response = await http.post(
      Uri.parse("${Constants.pedidos}.json?auth=$_token"),
      body: jsonEncode(
        {
          "total": cart.totalAmount,
          "products": cart.items.values
              .map(
                (e) => {
                  "id": e.getId,
                  "productId": e.getProductId,
                  "productTitle": e.getTitle,
                  "quantify": e.getQuantify,
                  "price": e.getPrice,
                },
              )
              .toList(),
          "data": data.toIso8601String(),
        },
      ),
    );
    _items.insert(
      0,
      Order(
        id: jsonDecode(response.body)["name"],
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        data: data,
      ),
    );
    notifyListeners();
  }
}
