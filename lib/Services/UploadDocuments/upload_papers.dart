import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<void> postPapers(String? authToken, String paperTitle, String paperYear, String sem, String code, String path, String name) async {
  // Replace the URL and token with your actual values
  final String baseUrl = dotenv.get('BaseUrl');
  var url = Uri.parse('$baseUrl/papers/');
  String token =
      'Bearer $authToken';

  // Replace these values with your form data
  String title = paperTitle;
  String year = paperYear;
  String semester = sem;
  String courses = code;

  String filePath = path;

  // Create multipart request
  var request = http.MultipartRequest('POST', url);
  request.headers['Authorization'] = token;
  request.headers['accept'] = 'application/json';

  // Add form data
  request.fields['title'] = title;
  request.fields['year'] = year;
  request.fields['semester'] = semester;
  request.fields['courses'] = courses;

  // Add file
  var file = await http.MultipartFile.fromPath('file', filePath, filename: name);
  request.files.add(file);

  try {
    // Send the request
    var response = await request.send();

    // Get response
    var responseBody = await response.stream.bytesToString();
    print('Response: $responseBody');
  } catch (error) {
    print('Error: $error');
  }
}