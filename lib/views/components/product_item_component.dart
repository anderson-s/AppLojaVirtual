import 'package:app_loja_virtual/controller/controller_product.dart';
import 'package:app_loja_virtual/models/product.dart';
import 'package:app_loja_virtual/models/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItemComponent extends StatelessWidget {
  final Product product;
  const ProductItemComponent({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.getImageUrl),
      ),
      title: Text(product.getTitle),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.formProduct,
                    arguments: product,
                  );
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.primary,
                )),
            IconButton(
              onPressed: () {
                showDialog<bool>(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: const Text("Tem Certeza?"),
                      content: const Text("Quer mesmo remover o produto?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(false);
                          },
                          child: const Text("Não"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(true);
                          },
                          child: const Text("Sim"),
                        ),
                      ],
                    );
                  },
                ).then((value) async {
                  if (value ?? false) {
                    try {
                      await Provider.of<ControllerProduct>(context,
                              listen: false)
                          .deleteProduct(product);
                    } catch (error) {
                      msg.showSnackBar(
                        const SnackBar(
                          content: Text("Não foi possível excluir o produto."),
                        ),
                      );
                    }
                  }
                });
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
