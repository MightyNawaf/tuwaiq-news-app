import 'dart:convert';
import 'dart:developer';

import 'package:disney/models/news.dart';
import 'package:http/http.dart' as http;

class NewsService {
  Future<News> getNews(String query) async {
    final response = await http.get(
      Uri.parse('https://newsapi.org/v2/everything?q=$query&sortBy=publishedAt'),
      headers: {
        'X-Api-Key': '852d4cad08974e2c8077fde3c83e4f04',
      },
    );
    log('Res: ${response.statusCode}');
    final responseAsJson = json.decode(response.body);
    final result = News.fromJson(responseAsJson);

    return result;
  }
}
