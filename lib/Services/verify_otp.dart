import 'dart:convert';
import 'package:bytepad/Models/verify_otp_reponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Views/Pages/authentication/reset_password_page.dart';

Future<void> verifyResetPasswordOTP(String email, String otp, BuildContext context) async {
  var url = Uri.parse('https://bytepad.onrender.com/auth/reset-password/verify-otp/');
  var headers = {
    'accept': 'application/json',
    'Content-Type': 'application/json'
  };
  var body = jsonEncode({
    "mail": email,
    "otp": otp,
  });

  var response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    Map<String, dynamic> verifyOTPResponse = jsonDecode(response.body);
    VerifyOTPResponse verifyOTP = VerifyOTPResponse.fromJson(verifyOTPResponse);
    var token = verifyOTP.token;
    print('OTP verification successful');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResetPasswordScreen(token: token),
      ),
    );
    print(jsonDecode(response.body));
  } else {
    print('Error: ${response.statusCode}');
    print(jsonDecode(response.body));
  }
}
