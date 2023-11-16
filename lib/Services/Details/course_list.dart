import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../Models/Details/course_list_model.dart';

Future<List<String>> getCourseNames(String? authToken) async {
  try {
    final String baseUrl = dotenv.get('BaseUrl');
    var url = Uri.parse('$baseUrl/details/courses/');

    final response = await http.get(
      url,
      headers: {
        'accept': 'application/json',
        'Authorization':
        'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final courseListModel = CourseListModel.fromJson(jsonResponse);

      if (courseListModel.results != null) {
        return courseListModel.results!.map((result) => result.name!).toList();
      } else {
        print('No results found');
        return [];
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Error: $e');
    return [];
  }
}
