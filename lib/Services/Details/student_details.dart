import '../../Models/Details/student_details_model.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<StudentDetailsModel?> getStudentDetails(String? authToken) async {
  print('hhhhhhhhhhh');
  try {
    final String baseUrl = dotenv.get('BaseUrl');
    var url = Uri.parse('$baseUrl/details/user/');

    final response = await http.get(
      url,
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      // Successful request, parse the response data into StudentDetailsModel
      final responseData = json.decode(response.body);
      print(responseData);
      return StudentDetailsModel.fromJson(responseData);
    } else {
      // Request failed, handle error accordingly
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return null;
    }
  } catch (e) {
    // Handle any exceptions that occur during the HTTP request
    print('Exception during request: $e');
    return null;
  }
}
