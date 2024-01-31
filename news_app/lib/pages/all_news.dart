import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/models/slider_model.dart';
import 'package:news_app/services/news.dart';
import 'package:news_app/services/slider_data.dart';
import 'package:news_app/widgets/all_news_section.dart';

class AllNews extends StatefulWidget {
  const AllNews({super.key, required this.news});
  final String news;

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<CategoryModel> categories = [];
  List<SliderModel> sliders = [];
  List<ArticleModel> articles = [];
  bool _loading = true;
  int activeIndex = 0;
  @override
  void initState() {
    getSliderNews();
    getNews();
    super.initState();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  getSliderNews() async {
    SliderNews slider = SliderNews();
    await slider.getSlider();
    sliders = slider.slider;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "${widget.news} News",
          style: GoogleFonts.aboreto(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: widget.news == "Breaking"
                    ? sliders.length
                    : articles.length,
                itemBuilder: (context, index) {
                  return AllNewsSection(
                    image: widget.news == "Breaking"
                        ? sliders[index].urlToImage ?? ""
                        : articles[index].urlToImage ?? "",
                    description: widget.news == "Breaking"
                        ? sliders[index].description ?? ""
                        : articles[index].description ?? "",
                    title: widget.news == "Breaking"
                        ? sliders[index].title ?? ""
                        : articles[index].title ?? "",
                    url: widget.news == "Breaking"
                        ? sliders[index].url ?? ""
                        : articles[index].url ?? "",
                  );
                },
              ),
            ),
    );
  }
}
