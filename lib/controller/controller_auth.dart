import 'dart:convert';

import 'package:app_loja_virtual/models/services/contants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ControllerAuth with ChangeNotifier {
  Future<void> signup(String email, String password) async {
    final response = await http.post(
      Uri.parse(Constants.cadastro),
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
}
