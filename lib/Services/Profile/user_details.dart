import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../Models/UserModels/student_user_model.dart';

Future<StudentUserModel> fetchUserData(String token) async {
  final String baseURl = dotenv.get('BaseUrl');
  var url = Uri.parse('$baseURl/users/');
  var accessToken = token;

  try {
    var response = await http.get(
      url,
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      print(StudentUserModel.fromJson(jsonData));
      return StudentUserModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load user data');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}