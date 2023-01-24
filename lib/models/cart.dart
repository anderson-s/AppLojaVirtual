
class Cart {
  final String id;
  final String productId;
  final String title;
  final int quantify;
  final double price;
  Cart({
    required this.id,
    required this.productId,
    required this.title,
    required this.quantify,
    required this.price,
  });

  String get getId => id;

  set setId(String id) => id = id;

  get getProductId => productId;

  set setProductId(productId) => productId = productId;

  get getTitle => title;

  set setTitle(title) => title = title;

  get getQuantify => quantify;

  set setQuantify(quantify) => quantify = quantify;

  get getPrice => price;

  set setPrice(price) => price = price;
}
