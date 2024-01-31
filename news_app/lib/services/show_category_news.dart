import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news_app/key/api_key.dart';
import 'package:news_app/models/show_category.dart';

class ShowCategoryNews {
  List<ShowCategoryModel> categories = [];

  Future<void> getCategories(String category) async {
    String url =
        "$baseUrl/top-headlines?country=us&category=$category&apiKey=$apiKey";

    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData['status'] == 'ok') {
          jsonData['articles'].forEach((e) {
            if (e['urlToImage'] != null && e['description'] != null) {
              ShowCategoryModel showCategoryModel = ShowCategoryModel(
                author: e["author"],
                title: e["title"],
                description: e["description"],
                content: e["content"],
                url: e["url"],
                urlToImage: e["urlToImage"],
              );
              categories.add(showCategoryModel);
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
