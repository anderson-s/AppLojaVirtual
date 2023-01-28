import 'package:app_loja_virtual/models/utils/validations.dart';
import 'package:flutter/material.dart';

enum AuthMode { sinup, login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  AuthMode _authMode = AuthMode.login;
  bool verSenha = false;
  bool progresso = false;
  final TextEditingController _controllerPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Map<String, String> _formData = {
    "email": "",
    "password": "",
  };

  void _submit() {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    setState(() {
      progresso = true;
    });
    formKey.currentState?.save();
    if(isLogin()){
      //Login 
    }else{
      //registrar
    }
  }

  bool isLogin() => _authMode == AuthMode.login;

  void selecionarModo() {
    setState(() {
      if (isLogin()) {
        _authMode = AuthMode.sinup;
      } else {
        _authMode = AuthMode.login;
      }
    });
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
      child: Container(
        padding: const EdgeInsets.all(16),
        height: isLogin() ? 310 : 400,
        width: deviceSize.width * 0.75,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "E-mail",
                ),
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) => _formData["email"] ?? "",
                validator: (email) => Validations.validarEmail(email),
              ),
              TextFormField(
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
                onSaved: (password) => _formData["password"] ?? "",
                validator: (value) =>
                    Validations.validarSenha(value.toString()),
              ),
              if (!isLogin())
                TextFormField(
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
                    if (_controllerPassword.text != value.toString()) {
                      return "As senhas informadas não conferem";
                    }
                    return null;
                  },
                ),
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
                  isLogin() ? "Deseja Registrar?" : "Já possui conta?",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
