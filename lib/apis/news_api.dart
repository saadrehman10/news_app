import 'package:news_app/apis/api_keys.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:news_app/models/headlines.dart';

class NewsApis {
  static Future<Headlines> newsApisHeadlines({required String countryCode}) async {
    final String url =
        'https://newsapi.org/v2/top-headlines?country=$countryCode&apiKey=$news_api_keys';
    final apiResponse = await http.get(Uri.parse(url));
    if (apiResponse.statusCode == 200) {
      final jsonDecodedData = jsonDecode(apiResponse.body);
      return Headlines.fromJson(jsonDecodedData);
    } else {
      throw Exception('The Response wasn\'t 200');
    }
  }
}
