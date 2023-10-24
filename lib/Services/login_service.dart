import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/generate_token_error.dart';
import '../Models/generate_token_response.dart';
import '../Views/Pages/home_page.dart';

Future<Map<String, dynamic>> loginUser(String email, String password, BuildContext context) async {
  var url = Uri.parse('https://bytepad.onrender.com/auth/generate/');
  var headers = {
    'accept': 'application/json',
    'Content-Type': 'application/json'
  };
  var body = jsonEncode({
    "email": email,
    "password": password,
  });

  var response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    Map<String, dynamic> generateResponse = jsonDecode(response.body);
    GenerateTokenResponse generateTokenResponse = GenerateTokenResponse.fromJson(generateResponse);
    var accessToken = generateTokenResponse.access;
    print(accessToken);
    print(jsonDecode(response.body));

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => HomePage(),
    ));

    return jsonDecode(response.body);
  }
  else {
    Map<String, dynamic> errorResponse = jsonDecode(response.body);
    GenerateTokenError generateTokenError = GenerateTokenError.fromJson(errorResponse);
    print(generateTokenError.detail);
    throw Exception('Failed to login');
  }
}
