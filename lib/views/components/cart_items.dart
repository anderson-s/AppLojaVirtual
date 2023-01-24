import 'package:app_loja_virtual/controller/controller_cart.dart';
import 'package:app_loja_virtual/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final Cart cart;
  const CartItem({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (_) {
        Provider.of<ControllerCart>(context, listen: false)
            .removeItem(cart.productId);
      },
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.only(
          right: 20,
        ),
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      key: ValueKey(cart.getId),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(
                  5,
                ),
                child: FittedBox(
                  child: Text("${cart.price}"),
                ),
              ),
            ),
            title: Text(cart.title),
            subtitle: Text("R\$ ${cart.getPrice * cart.quantify}"),
            trailing: Text("${cart.quantify}x"),
          ),
        ),
      ),
    );
  }
}
