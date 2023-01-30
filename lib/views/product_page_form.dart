import 'package:app_loja_virtual/controller/controller_product.dart';
import 'package:app_loja_virtual/models/product.dart';

import 'package:app_loja_virtual/models/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProductPageForm extends StatefulWidget {
  const ProductPageForm({super.key});

  @override
  State<ProductPageForm> createState() => _ProductPageFormState();
}

class _ProductPageFormState extends State<ProductPageForm> {
  final priceFocus = FocusNode();
  final descriptionFocus = FocusNode();
  final urlFocus = FocusNode();
  final controllerUrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};
  bool progresso = false;
  @override
  void initState() {
    super.initState();
    controllerUrl.addListener(atualizarImagem);
  }

  @override
  void dispose() {
    priceFocus.dispose();
    descriptionFocus.dispose();
    urlFocus.removeListener(atualizarImagem);
    urlFocus.dispose();
    super.dispose();
  }

  atualizarImagem() {
    setState(() {});
  }

  Future<void> submitForm() async {
    final isvalid = _formKey.currentState?.validate() ?? false;
    if (!isvalid) {
      return;
    } else {
      _formKey.currentState?.save();
      setState(() => progresso = true);
      try {
        await Provider.of<ControllerProduct>(context, listen: false)
            .saveProductFromData(_formData)
            .then((value) => Navigator.of(context).pop());
      } catch (error) {
        await showDialog<void>(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text(
                "Ocorreu um erro!",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              content:
                  const Text("Ocorreu um erro ao tentar salvar o produto!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Ok"),
                )
              ],
            );
          },
        );
      } finally {
        setState(() => progresso = false);
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null) {
        final product = arg as Product;
        _formData["id"] = product.getId;
        _formData["name"] = product.getTitle;
        _formData["description"] = product.getDescription;
        _formData["price"] = product.getPrice;
        _formData["imageUrl"] = product.getImageUrl;
        _formData["isFavorite"] = product.getIsFavorite;
        controllerUrl.text = product.getImageUrl;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulário de Produto"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              submitForm();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: progresso
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _formData["name"]?.toString(),
                      decoration: const InputDecoration(
                        labelText: "Nome",
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(priceFocus);
                      },
                      onSaved: (name) => _formData["name"] = name ?? "",
                      validator: (value) => Validations.validarNome(value),
                    ),
                    TextFormField(
                      initialValue: _formData["price"]?.toString(),
                      decoration: const InputDecoration(labelText: "Preço"),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textInputAction: TextInputAction.next,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      focusNode: priceFocus,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(descriptionFocus);
                      },
                      onSaved: (price) => _formData["price"] =
                          double.tryParse(price.toString()) ?? 0.0,
                      validator: (value) => Validations.validarPreco(value),
                    ),
                    TextFormField(
                      initialValue: _formData["description"]?.toString(),
                      decoration: const InputDecoration(labelText: "Descrição"),
                      focusNode: descriptionFocus,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(urlFocus);
                      },
                      onSaved: (description) =>
                          _formData["description"] = description ?? "",
                      validator: (value) => Validations.validarDescricao(value),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controllerUrl,
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(
                              labelText: "Url da Imagem",
                            ),
                            focusNode: urlFocus,
                            keyboardType: TextInputType.url,
                            onFieldSubmitted: (_) => submitForm(),
                            validator: (value) => Validations.validarUrl(value),
                            onSaved: (urlImage) =>
                                _formData["urlImage"] = urlImage ?? "",
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: controllerUrl.text.isEmpty
                              ? const Text("Informe a Url")
                              : Image.network(
                                  controllerUrl.text,
                                ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
