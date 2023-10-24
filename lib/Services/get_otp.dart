import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> requestResetPasswordOTP(String email) async {
  var url = Uri.parse('https://bytepad.onrender.com/auth/reset-password/get-otp/');
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
  } else {
    print('Error: ${response.statusCode}');
    print(jsonDecode(response.body));
  }
}
