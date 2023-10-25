import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../Views/Pages/authentication/success_screen.dart';

Future<void> resetPassword(String? token, String newPassword, BuildContext context) async {
  var url = Uri.parse('https://bytepad.onrender.com/auth/reset-password/');
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SuccessScreen(),
      ),
    );
  } else {
    print('Error: ${response.statusCode}');
    print(jsonDecode(response.body));
  }
}
