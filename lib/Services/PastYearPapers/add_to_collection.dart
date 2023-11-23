import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<void> addToCollection(String? authToken, String? paperId) async {
  final String baseUrl = dotenv.get('BaseUrl');
  var url = Uri.parse('$baseUrl/papers/collections/');
  final headers = {
    'accept': 'application/json',
    'Authorization':
    'Bearer $authToken',
    'Content-Type': 'application/json',
  };
  final body = {'paper': paperId};

  final response = await http.post(
    url,
    headers: headers,
    body: jsonEncode(body),
  );

  if (response.statusCode == 201) {
    print('Request successful: ${response.body}');
  } else {
    print('Request failed with status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
