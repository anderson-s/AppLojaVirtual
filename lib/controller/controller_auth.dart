import 'dart:convert';

import 'package:app_loja_virtual/models/services/contants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ControllerAuth with ChangeNotifier {
  Future<void> services(
    String email,
    String password,
    String optionService,
  ) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:${optionService}?key=AIzaSyBaWcEzSZNb11vAdOEOKBriNqUFIcddLmk";
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
    print(jsonDecode(response.body));
  }

  Future<void> signup(String email, String password) async {
    return services(email, password, "signUp");
  }

  Future<void> signin(String email, String password) async {
    return services(email, password, "signInWithPassword");
  }
}
