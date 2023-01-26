import 'dart:math';

import 'package:app_loja_virtual/models/product.dart';
import 'package:app_loja_virtual/models/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  void submitForm() {
    final isvalid = _formKey.currentState?.validate() ?? false;
    if (!isvalid) {
      return;
    } else {
      _formKey.currentState?.save();
      final newProduct = Product(
        id: Random().nextDouble().toString(),
        title: _formData["name"].toString(),
        description: _formData["description"].toString(),
        price: _formData["price"] as double,
        imageUrl: _formData["urlImage"].toString(),
      );
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
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
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
                        : FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(
                              controllerUrl.text,
                            ),
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
