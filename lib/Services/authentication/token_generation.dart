import 'dart:convert';
import 'package:bytepad/Services/authentication/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../Models/Details/student_details_model.dart';
import '../../Models/authentication/generate_token_error.dart';
import '../../Models/authentication/generate_token_response.dart';
import '../../Views/Pages/Home/FacultySide.dart';
import '../../Views/Pages/Home/HodSide.dart';
import '../../Views/Pages/Home/StudentSide.dart';
import '../Details/student_details.dart';

Future<String?> loginUser(String email, String password, BuildContext context) async {
  final String baseURl = dotenv.get('BaseUrl');
  var url = Uri.parse('$baseURl/auth/generate/');
  var headers = {
    'accept': 'application/json',
    'Content-Type': 'application/json'
  };
  var body = jsonEncode({
    "email": email,
    "password": password,
  });

  var response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    Map<String, dynamic> generateResponse = jsonDecode(response.body);
    GenerateTokenResponse generateTokenResponse = GenerateTokenResponse.fromJson(generateResponse);
    final SecureStorage secureStorage = SecureStorage();
    secureStorage.writeSecureData('accessToken', generateTokenResponse.access);
    print(jsonDecode(response.body));

    StudentDetailsModel? studentDetails = await getStudentDetails(generateTokenResponse.access);

    if (studentDetails != null && studentDetails.isStudent == true && studentDetails.isFaculty == false && studentDetails.isDepartmentHead == false) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => StudentSide(studentDetails: studentDetails,)),
      );
    }
    else if (studentDetails != null && studentDetails.isStudent == false && studentDetails.isFaculty == true && studentDetails.isDepartmentHead == false) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FacultySide()),
      );
    }
    else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HodSide()),
      );
    }
    // else {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => FirstOnboardingScreen()),
    //   );
    // }

    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => StudentSide(),
    //   ),
    // );
    return null;
  }
  else {
    Map<String, dynamic> errorResponse = jsonDecode(response.body);
    GenerateTokenError generateTokenError = GenerateTokenError.fromJson(errorResponse);
    print(generateTokenError.detail);
    return jsonDecode(response.body)['detail'];
  }
}
