import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../Models/Details/course_list_model.dart';

Future<List<String>> getCourseNames(String? authToken) async {
  try {
    final String baseUrl = dotenv.get('BaseUrl');
    var url = Uri.parse('$baseUrl/details/courses/');

    List<String> allCourseNames = [];
    String? nextUrl;

    do {
      // Make the API call
      final response = await http.get(
        nextUrl != null ? Uri.parse(nextUrl) : url,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final courseListModel = CourseListModel.fromJson(jsonResponse);

        if (courseListModel.results != null) {
          // Extract names from the current page
          List<String> pageCourseNames =
          courseListModel.results!.map((result) => result.name!).toList();

          // Add names to the overall list
          allCourseNames.addAll(pageCourseNames);

          // Get the next API URL for pagination
          nextUrl = courseListModel.next;

          // Ensure nextUrl is not null before assigning it
          if (nextUrl == null) {
            break;
          }
        } else {
          print('No results found');
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } while (nextUrl != null);

    return allCourseNames;
  } catch (e) {
    print('Error: $e');
    return [];
  }
}
