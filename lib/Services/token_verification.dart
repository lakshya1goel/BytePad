import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/generate_token_error.dart';
import '../Views/Pages/home_page.dart';

Future<void> verifyToken(String? token, BuildContext context) async {
  var url = Uri.parse('https://bytepad.onrender.com/auth/verify/');
  var headers = {
    'accept': 'application/json',
    'Content-Type': 'application/json'
  };
  var body = jsonEncode({
    "token": token,
  });

  var response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    print('Token verification successful');
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => HomePage(),
    ));

  } else {
    Map<String, dynamic> errorResponse = jsonDecode(response.body);
    GenerateTokenError generateTokenError = GenerateTokenError.fromJson(errorResponse);
    print(generateTokenError.detail);
  }
}
