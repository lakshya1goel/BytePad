import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../Models/UserModels/user_model.dart';

Future<UserModel?> UserDetails(String? authToken) async {
  final String baseUrl = dotenv.get('BaseUrl');
  var url = Uri.parse('$baseUrl/details/user/');

  final String token = 'Bearer $authToken';

  final Map<String, String> headers = {
    'accept': 'application/json',
    'Authorization': token,
  };

  try {
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return UserModel.fromJson(data);
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return null;
    }
  } catch (error) {
    print('Error: $error');
    return null;
  }
}
