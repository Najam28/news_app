import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/show_category.dart';
import 'package:news_app/services/show_category_news.dart';
import 'package:news_app/widgets/show_category.dart';

class CategoryNews extends StatefulWidget {
  const CategoryNews({super.key, required this.name});
  final String name;

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryModel> categoriesModel = [];
  bool _loading = true;

  getCategories() async {
    ShowCategoryNews showCategoryModel = ShowCategoryNews();
    await showCategoryModel.getCategories(widget.name.toLowerCase());
    categoriesModel = showCategoryModel.categories;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          widget.name,
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
                itemCount: categoriesModel.length,
                itemBuilder: (context, index) {
                  return ShowCategory(
                    image: categoriesModel[index].urlToImage ?? '',
                    description: categoriesModel[index].description ?? '',
                    title: categoriesModel[index].title ?? '',
                    url: categoriesModel[index].url ?? '',
                  );
                },
              ),
            ),
    );
  }
}
