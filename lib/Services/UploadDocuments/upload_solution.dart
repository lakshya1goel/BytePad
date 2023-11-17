import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

Future<void> uploadSolution(String authToken, String paperId, String filePath, String name) async {
  try {
    final String baseUrl = dotenv.get('BaseUrl');
    var url = Uri.parse('$baseUrl/papers/solutions/');

    var request = http.MultipartRequest('POST', url);

    // Set headers
    request.headers['accept'] = 'application/json';
    request.headers['Authorization'] = 'Bearer $authToken';

    // Add form fields
    request.fields['paper'] = paperId;

    // Add file
    var file = await http.MultipartFile.fromPath('file', filePath, filename: name);
    request.files.add(file);

    // Send the request
    var response = await request.send();

    // Get response
    var responseBody = await response.stream.bytesToString();
    print('Response: $responseBody');
  } catch (error) {
    print('Error: $error');
  }
}

