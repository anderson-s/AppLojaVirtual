import 'package:app_loja_virtual/controller/controller_cart.dart';
import 'package:app_loja_virtual/controller/controller_order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExtractButton extends StatefulWidget {
  final ControllerCart cart;
  const ExtractButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  State<ExtractButton> createState() => _ExtractButtonState();
}

class _ExtractButtonState extends State<ExtractButton> {
  bool progress = false;
  @override
  Widget build(BuildContext context) {
    return progress
        ? const CircularProgressIndicator()
        : TextButton(
            style: TextButton.styleFrom(
              textStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onPressed: widget.cart.countItems == 0
                ? null
                : () async {
                    setState(() {
                      progress = true;
                    });
                    await Provider.of<ControllerOrder>(context, listen: false)
                        .addOrder(widget.cart)
                        .then((value) {
                      widget.cart.clearCart();

                      setState(() {
                        progress = false;
                      });
                    });
                  },
            child: const Text(
              "COMPRAR",
            ),
          );
  }
}
