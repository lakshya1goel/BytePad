import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<String?> resetPassword(String? token, String newPassword, BuildContext context) async {
  final String baseURl = dotenv.get('BaseUrl');
  var url = Uri.parse('$baseURl/auth/reset-password/');
  var headers = {
    'accept': 'application/json',
    'Content-Type': 'application/json'
  };
  var body = jsonEncode({
    "token": token,
    "new_password": newPassword,
  });

  var response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    print('Password reset successful');
    print(jsonDecode(response.body));
    return null;
  } else {
    print('Error: ${response.statusCode}');
    print(jsonDecode(response.body));
    return jsonDecode(response.body)['error'];
  }
}
