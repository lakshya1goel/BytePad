import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../Models/PastYearPapers/myCollection_paper_list_model.dart';

Future<List<Results>> getPapersFromCollection(String? authToken) async {
  final String baseUrl = dotenv.get('BaseUrl');
  final url = Uri.parse('$baseUrl/papers/collections/');
  final headers = {
    'accept': 'application/json',
    'Authorization':
    'Bearer $authToken',
  };

  final response = await http.get(
    url,
    headers: headers,
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    print('Raw response: $jsonResponse');
    final MyCollectionsPaperListModel myCollectionsModel = MyCollectionsPaperListModel.fromJson(jsonResponse);
    print(myCollectionsModel.results ?? []);
    return myCollectionsModel.results ?? [];
  } else {
    print('Request failed with status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return [];
  }
}