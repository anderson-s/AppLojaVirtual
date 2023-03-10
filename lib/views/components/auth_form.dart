import 'package:app_loja_virtual/controller/controller_auth.dart';
import 'package:app_loja_virtual/models/exceptions/exceptions_auth.dart';
import 'package:app_loja_virtual/models/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode { sinup, login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  AuthMode _authMode = AuthMode.login;
  bool verSenha = false;
  bool progresso = false;
  bool valueCheck = false;
  final TextEditingController _controllerPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {
    "email": "",
    "password": "",
  };
  AnimationController? _controllerAnimation;
  Animation<double>? _opacityAnimation;
  Animation<Offset>? _slideAnimation;
  bool isLogin() => _authMode == AuthMode.login;
  void selecionarModo() {
    setState(() {
      if (isLogin()) {
        _authMode = AuthMode.sinup;
        _controllerAnimation?.forward();
      } else {
        _authMode = AuthMode.login;
        _controllerAnimation?.reverse();
      }
    });
  }

  popUpError(String msg) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text(
            "Ocorreu um erro!",
            style: TextStyle(
              fontFamily: "Lato",
              color: Colors.black,
            ),
          ),
          content: Text(
            msg,
            style: const TextStyle(
              fontFamily: "Lato",
              color: Colors.black,
            ),
          ),
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
  }

  Future<void> _submit() async {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    setState(() {
      progresso = true;
    });
    _formKey.currentState?.save();
    final auth = Provider.of<ControllerAuth>(context, listen: false);
    try {
      isLogin()
          ? await auth.signin(_formData["email"]!, _formData["password"]!)
          : await auth.signup(_formData["email"]!, _formData["password"]!);
    } on ExceptionsAuth catch (error) {
      popUpError(error.toString());
    } finally {
      setState(() => progresso = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _controllerAnimation = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controllerAnimation!,
        curve: Curves.linear,
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controllerAnimation!,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controllerAnimation?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 300,
        ),
        curve: Curves.easeIn,
        height: isLogin() ? 310 : 400,
        padding: const EdgeInsets.all(16),
        width: deviceSize.width * 0.75,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "E-mail",
                  suffixIcon: IconButton(
                    onPressed: null,
                    icon: Icon(Icons.email),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) => _formData["email"] = email.toString(),
                validator: Validations.validarEmail,
              ),
              TextFormField(
                controller: _controllerPassword,
                decoration: InputDecoration(
                  labelText: "Senha",
                  suffixIcon: isLogin()
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              verSenha = !verSenha;
                            });
                          },
                          icon: Icon(
                            verSenha ? Icons.visibility : Icons.visibility_off,
                          ),
                        )
                      : const Icon(Icons.key),
                ),
                obscureText: (!isLogin()) ? true : !verSenha,
                keyboardType: TextInputType.visiblePassword,
                onSaved: (password) =>
                    _formData["password"] = password.toString(),
                validator: Validations.validarSenha,
              ),
              AnimatedContainer(
                duration: const Duration(
                  milliseconds: 300,
                ),
                constraints: BoxConstraints(
                  minHeight: isLogin() ? 0 : 60,
                  maxHeight: isLogin() ? 0 : 120,
                ),
                curve: Curves.linear,
                child: FadeTransition(
                  opacity: _opacityAnimation!,
                  child: SlideTransition(
                    position: _slideAnimation!,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Confirmar Senha",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              verSenha = !verSenha;
                            });
                          },
                          icon: Icon(
                            verSenha ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                      ),
                      obscureText: !verSenha,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (!isLogin()) {
                          final valor = value ?? "";
                          if (_controllerPassword.text != valor) {
                            return "As senhas informadas n??o conferem";
                          }
                          return null;
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Esqueceu a senha?"),
              const SizedBox(
                height: 20,
              ),
              if (progresso)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 8,
                    ),
                  ),
                  child: Text(
                    isLogin() ? "Entrar" : "Registrar",
                  ),
                ),
              const Spacer(),
              TextButton(
                onPressed: selecionarModo,
                child: Text(
                  isLogin() ? "Deseja Registrar?" : "J?? possui conta?",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
