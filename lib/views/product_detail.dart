import 'package:app_loja_virtual/models/product.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                product.getTitle,
                textAlign: TextAlign.center,
              ),
              background: Hero(
                tag: product.getId,
                child: AspectRatio(
                  aspectRatio: 3.4,
                  child: Image.network(
                    product.imageUrl,
                    // fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "R\$ ${product.getPrice}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Text(
                    product.getDescription,
                    textAlign: TextAlign.center,
                  ),
                ),
              
              ],
            ),
          ),
        ],
      ),
    );
  }
}
