import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class ApiService {
  final String apiKey = '2fb7812f7a27445e8f9bc10e34bae973';
  final String baseUrl = 'https://newsapi.org/v2/';

  Future<List<Article>> fetchArticles(String category) async {
    final response = await http.get(Uri.parse('$baseUrl/top-headlines?category=$category&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Article> articles = (data['articles'] as List)
          .map((articleJson) => Article.fromJson(articleJson))
          .toList();
      return articles;
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
