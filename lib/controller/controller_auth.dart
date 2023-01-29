import 'dart:convert';

import 'package:app_loja_virtual/models/exceptions/exceptions_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ControllerAuth with ChangeNotifier {
  String? _token;
  String? _email;
  String? _uid;
  DateTime? _expiryDate;

  bool get isAuth {
    final isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get uid {
    return isAuth ? _uid : null;
  }

  Future<void> services(
    String email,
    String password,
    String optionService,
  ) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$optionService?key=AIzaSyBaWcEzSZNb11vAdOEOKBriNqUFIcddLmk";

    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(
        {
          "email": email,
          "password": password,
          "returnSecureToken": true,
        },
      ),
    );

    final body = jsonDecode(response.body);
    if (body["error"] != null) {
      throw ExceptionsAuth(msg: body["error"]["message"]);
    } else {
      _token = body["idToken"];
      _email = body["email"];
      _uid = body["localId"];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            body["expiresIn"],
          ),
        ),
      );
      notifyListeners();
    }
  }

  Future<void> signup(String email, String password) async {
    return services(email, password, "signUp");
  }

  Future<void> signin(String email, String password) async {
    return services(email, password, "signInWithPassword");
  }
}
