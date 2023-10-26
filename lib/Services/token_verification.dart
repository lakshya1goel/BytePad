import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/generate_token_error.dart';
import '../Views/Pages/home_page.dart';

Future<String?> verifyToken(String? token) async {
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
    return null;

  } else {
    Map<String, dynamic> errorResponse = jsonDecode(response.body);
    GenerateTokenError generateTokenError = GenerateTokenError.fromJson(errorResponse);
    print(generateTokenError.detail);
    return jsonDecode(response.body)['detail'];
  }
}
