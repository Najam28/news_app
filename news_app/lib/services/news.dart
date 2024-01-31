import 'dart:convert';
import 'dart:developer';

import 'package:news_app/key/api_key.dart';
import 'package:news_app/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url =
        "$baseUrl/everything?q=tesla&from=2023-12-29&sortBy=publishedAt&apiKey=$apiKey";

    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData['status'] == 'ok') {
          jsonData['articles'].forEach((e) {
            if (e['urlToImage'] != null && e['description'] != null) {
              ArticleModel articleModel = ArticleModel(
                author: e["author"],
                title: e["title"],
                description: e["description"],
                content: e["content"],
                url: e["url"],
                urlToImage: e["urlToImage"],
              );
              news.add(articleModel);
            }
          });
        }
      } else {
        log('Failed to load news');
      }
    } catch (e) {
      log('Error fetching news: $e');
    }
  }
}
