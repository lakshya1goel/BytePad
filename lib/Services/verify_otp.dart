import 'dart:convert';
import 'package:bytepad/Models/verify_otp_reponse.dart';
import 'package:bytepad/Models/verify_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<VerifyResponse> verifyResetPasswordOTP(String email, String otp, BuildContext context) async {
  final String baseURl = dotenv.get('BaseUrl');
  var url = Uri.parse('$baseURl/auth/reset-password/verify-otp/');
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
    print(jsonDecode(response.body));
    return VerifyResponse(token: token, error: null);
  } else {
    print('Error: ${response.statusCode}');
    print(jsonDecode(response.body));
    return VerifyResponse(token: null, error: jsonDecode(response.body)['error']);
  }
}
