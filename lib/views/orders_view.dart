import 'package:app_loja_virtual/controller/controller_order.dart';
import 'package:app_loja_virtual/views/components/app_drawer.dart';
import 'package:app_loja_virtual/views/components/order_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  bool progresso = true;
  @override
  void initState() {
    Provider.of<ControllerOrder>(context, listen: false)
        .loadOrder()
        .then((value) {
      setState(() {
        progresso = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ControllerOrder orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Pedidos"),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: progresso
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () =>
                  Provider.of<ControllerOrder>(context, listen: false)
                      .loadOrder(),
              child: ListView.builder(
                itemCount: orders.itemsCount,
                itemBuilder: (context, index) {
                  return OrderComponent(order: orders.items[index]);
                },
              ),
            ),
    );
  }
}
