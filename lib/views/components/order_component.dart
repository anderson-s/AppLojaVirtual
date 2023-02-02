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
    final itemsHeight = (widget.order.products.length * 24.0) + 10;
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 300,
      ),
      height: expandir ? itemsHeight + 80 : 80,
      child: Card(
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
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              height: expandir ? itemsHeight : 0,
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
      ),
    );
  }
}
