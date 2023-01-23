import 'package:app_loja_virtual/controller/controller_cart.dart';
import 'package:app_loja_virtual/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  // final Product product;
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<ControllerCart>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: (ctx, value, _) {
              return IconButton(
                onPressed: () {
                  product.togleIsFavorite();
                },
                icon: Icon(product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                color: Theme.of(context).colorScheme.secondary,
              );
            },
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(product);
              print(cart.countItems);
            },
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.secondary,
          ),
          title: Text(
            product.getTitle,
            textAlign: TextAlign.center,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/detail", arguments: product);
          },
          child: Image.network(
            product.getImageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
