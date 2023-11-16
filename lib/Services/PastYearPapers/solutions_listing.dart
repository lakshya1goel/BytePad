import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../Models/PastYearPapers/solution_listing_model.dart';

Future<SolutionListingModel?> solutionListing(String? authToken, int? paper_id) async {
  final String baseUrl = dotenv.get('BaseUrl');
  List<Results>? allSolutions;

  var url = Uri.parse('$baseUrl/papers/solutions/?paper_id=$paper_id');
  final String token = 'Bearer $authToken';

  try {
    final response = await http.get(
      url,
      headers: {
        'accept': 'application/json',
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      // Handle the successful response here
      print('Response: ${response.body}');

      // Parse the JSON response
      final Map<String, dynamic> data = json.decode(response.body);

      // Extract solutions from the response
      List<Results> solutions = (data['results'] as List)
          .map((solutionData) => Results.fromJson(solutionData))
          .toList();

      // Assign the solutions to the accumulated list
      allSolutions = solutions.isNotEmpty ? solutions : null;
    } else {
      // Handle error response
      print('Error: ${response.statusCode}, ${response.reasonPhrase}');
    }
  } catch (error) {
    // Handle network or other errors
    print('Error: $error');
  }

  return SolutionListingModel(results: allSolutions);
}
