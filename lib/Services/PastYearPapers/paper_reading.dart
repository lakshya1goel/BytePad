import 'dart:convert';

import 'package:bytepad/Models/PastYearPapers/paper_read_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<PaperReadModel?> paperRead(String? authToken, int? paperId) async {
  try {
    final String baseUrl = dotenv.get('BaseUrl');
    var url = Uri.parse('$baseUrl/papers/$paperId/');
    final headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer $authToken'
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      // Parse the JSON response and create a PaperReadModel instance
      final Map<String, dynamic> responseData = json.decode(response.body);
      final PaperReadModel paperModel = PaperReadModel.fromJson(responseData);

      // Return the PaperReadModel instance
      return paperModel;
    } else {
      // Handle HTTP error
      print('HTTP Error: ${response.statusCode}');
      return null; // Return null in case of an HTTP error
    }
  } catch (e) {
    // Handle exceptions during HTTP request or JSON parsing
    print('Error: $e');
    return null; // Return null in case of an exception
  }
}

