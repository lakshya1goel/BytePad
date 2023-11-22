import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Models/Details/students_list_model.dart';

Future<List<StudentsListModel>> getStudentList(String? authToken, String? id) async {
  try {
    final String url = 'https://bytepad.onrender.com/details/batch/student/$id';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'accept': 'application/json',
        'Authorization':
        'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      List<StudentsListModel> studentList = jsonList
          .map((jsonObject) => StudentsListModel.fromJson(jsonObject))
          .toList();
      return studentList;
    } else {
      throw Exception('Failed to load student list');
    }
  } catch (e) {
    print('Error in getStudentList: $e');
    rethrow;
  }
}