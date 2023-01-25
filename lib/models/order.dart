import 'package:app_loja_virtual/models/cart.dart';

class Order {
  final String id;
  final double total;
  final List<Cart> products;
  final DateTime data;

  Order({
    required this.id,
    required this.total,
    required this.products,
    required this.data,
  });
}
