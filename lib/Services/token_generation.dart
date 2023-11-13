import 'dart:convert';
import 'package:bytepad/Services/storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../Models/generate_token_error.dart';
import '../Models/generate_token_response.dart';

Future<String?> loginUser(String email, String password) async {
  final String baseURl = dotenv.get('BaseUrl');
  var url = Uri.parse('$baseURl/auth/generate/');
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
    final SecureStorage secureStorage = SecureStorage();
    secureStorage.writeSecureData('accessToken', generateTokenResponse.access);
    print(jsonDecode(response.body));
    return null;
  }
  else {
    Map<String, dynamic> errorResponse = jsonDecode(response.body);
    GenerateTokenError generateTokenError = GenerateTokenError.fromJson(errorResponse);
    print(generateTokenError.detail);
    return jsonDecode(response.body)['detail'];
  }
}
