import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../Models/PastYearPapers/papers_listing_model.dart';

Future<PaperListingModel?> paperListing(String? authToken) async {
  print("hehehe");
  final String baseUrl = dotenv.get('BaseUrl');
  int page = 1;
  List<Results>? allPapers;

  while (true) {
    var url = Uri.parse('$baseUrl/papers/?page=$page');
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
        print('Response for Page $page: ${response.body}');

        // Parse the JSON response
        final Map<String, dynamic> data = json.decode(response.body);

        // Extract papers from the current page
        List<Results> papers = (data['results'] as List)
            .map((paperData) => Results.fromJson(paperData))
            .toList();

        // Add papers to the accumulated list
        allPapers ??= [];
        allPapers.addAll(papers);

        // Check if the 'next' value is null
        if (data['next'] == null) {
          print('Reached the last page. Stopping the loop.');
          break;
        }

        // Increment the page for the next iteration
        page++;
      } else {
        // Handle error response
        print('Error for Page $page: ${response.statusCode}, ${response.reasonPhrase}');
        break; // Break the loop on error
      }
    } catch (error) {
      // Handle network or other errors
      print('Error for Page $page: $error');
      break; // Break the loop on error
    }
  }
  return PaperListingModel(results: allPapers);
}
