import 'package:app_loja_virtual/models/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderComponent extends StatefulWidget {
  final Order order;
  const OrderComponent({super.key, required this.order});

  @override
  State<OrderComponent> createState() => _OrderComponentState();
}

class _OrderComponentState extends State<OrderComponent> {
  bool expandir = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text("R\$ ${widget.order.total.toStringAsFixed(2)}"),
            subtitle: Text(
              DateFormat("dd/MM/yyyy HH:mm").format(widget.order.data),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  expandir = !expandir;
                });
              },
              icon: Icon(
                expandir ? Icons.expand_less : Icons.expand_more,
              ),
            ),
          ),
          if (expandir)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              height: (widget.order.products.length * 24.0) + 10,
              child: ListView(
                children: widget.order.products
                    .map(
                      (e) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            e.getTitle,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${e.getQuantify}x R\$ ${e.getPrice}",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
