import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../Models/Attendance/student_attendance_model.dart';

Future<StudentAttendanceDataModel?> fetchAttendanceData(String? authToken) async {
  final String baseUrl = dotenv.get('BaseUrl');
  var url = Uri.parse('$baseUrl/attendence/student/');

  Map<String, String> headers = {
    'accept': 'application/json',
    'Authorization':
    'Bearer $authToken'
  };

  try {
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      print(response.body);
      return StudentAttendanceDataModel.fromJson(json.decode(response.body));
    } else {
      print('Error: ${response.statusCode}, ${response.reasonPhrase}');
      return null;
    }
  } catch (e) {
    print("hhhhhhhh");
    print('Error: $e');
    return null;
  }
}