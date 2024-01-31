import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news_app/key/api_key.dart';
import 'package:news_app/models/slider_model.dart';

class SliderNews {
  List<SliderModel> slider = [];

  Future<void> getSlider() async {
    String url = "$baseUrl/top-headlines?sources=techcrunch&apiKey=$apiKey";

    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData['status'] == 'ok') {
          jsonData['articles'].forEach((e) {
            if (e['urlToImage'] != null && e['description'] != null) {
              SliderModel sliderModel = SliderModel(
                author: e["author"],
                title: e["title"],
                description: e["description"],
                content: e["content"],
                url: e["url"],
                urlToImage: e["urlToImage"],
              );
              slider.add(sliderModel);
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
