import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<String?> requestResetPasswordOTP(String email) async {
  final String baseURl = dotenv.get('BaseUrl');
  var url = Uri.parse('$baseURl/auth/reset-password/get-otp/');
  var headers = {
    'accept': 'application/json',
    'Content-Type': 'application/json'
  };
  var body = jsonEncode({
    "mail": email,
  });

  var response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    print('Request for OTP successful');
    print(jsonDecode(response.body));
    return null;
  } else {
    print('Error: ${response.statusCode}');
    print(jsonDecode(response.body));
    return jsonDecode(response.body)['error'];
  }
}