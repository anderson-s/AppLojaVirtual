import 'package:app_loja_virtual/models/product.dart';
import 'package:app_loja_virtual/models/utils/routes.dart';
import 'package:flutter/material.dart';

class ProductItemComponent extends StatelessWidget {
  final Product product;
  const ProductItemComponent({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ))
          ],
        ),
      ),
    );
  }
}
