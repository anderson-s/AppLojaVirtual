import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulário de Produto"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Nome"),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(priceFocus);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Preço"),
                textInputAction: TextInputAction.next,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                focusNode: priceFocus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(descriptionFocus);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Descrição"),
                focusNode: descriptionFocus,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(urlFocus);
                },
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
