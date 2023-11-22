import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Models/Details/batch_list_model.dart';

Future<List<BatchListModel>> getBatchList(String? authToken) async {
  try {
    final response = await http.get(Uri.parse('https://bytepad.onrender.com/details/batch/'), headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer $authToken',
    });

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print(response.body);
      return data.map((json) => BatchListModel.fromJson(json)).toList();
    } else {
      // Handle errors
      print('Error: ${response.statusCode}, ${response.reasonPhrase}');
      return [];
    }
  } catch (e) {
    // Handle exceptions
    print('Exception: $e');
    return [];
  }
}
