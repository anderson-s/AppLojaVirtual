import 'package:app_loja_virtual/controller/controller_order.dart';
import 'package:app_loja_virtual/views/components/app_drawer.dart';
import 'package:app_loja_virtual/views/components/order_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Pedidos"),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future:
            Provider.of<ControllerOrder>(context, listen: false).loadOrder(),
        builder: (ctx, snapshot) {
          if (snapshot.error != null) {
            return const Center(child: Text("Ocorreuu um erro!"));
          }
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              return Consumer<ControllerOrder>(
                builder: (ctx, value, child) {
                  if (value.itemsCount == 0) {
                    return const Center(
                      child: Text("Não existem pedidos!"),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: value.itemsCount,
                      itemBuilder: (ctx, index) {
                        return OrderComponent(order: value.items[index]);
                      },
                    );
                  }
                },
              );
          }
        },
      ),
    );
  }
}
