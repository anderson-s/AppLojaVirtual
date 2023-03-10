import 'package:app_loja_virtual/controller/controller_auth.dart';
import 'package:app_loja_virtual/controller/controller_cart.dart';
import 'package:app_loja_virtual/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<ControllerCart>(context);
    final auth = Provider.of<ControllerAuth>(context, listen: false);
    final msg = ScaffoldMessenger.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: (ctx, value, _) {
              return IconButton(
                onPressed: () async {
                  try {
                    await product.togleIsFavorite(
                      auth.token!,
                      auth.uid!,
                    );
                  } catch (error) {
                    msg.showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Não foi possível favoritar o produto.",
                        ),
                      ),
                    );
                  }
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
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 1),
                  content: const Text("Adicionado com sucesso"),
                  action: SnackBarAction(
                    label: "DESFAZER",
                    onPressed: () {
                      cart.removeSingleItem(product.getId);
                    },
                  ),
                ),
              );
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
          child: Hero(
            tag: product.getId,
            child: FadeInImage(
              placeholder: const AssetImage(
                "assets/images/product-placeholder.png",
              ),
              image: NetworkImage(
                product.getImageUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
