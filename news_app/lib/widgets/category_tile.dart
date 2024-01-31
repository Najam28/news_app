import 'package:flutter/material.dart';
import 'package:news_app/pages/category_news.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({super.key, this.image, this.categoryName});
  final dynamic image;
  final String? categoryName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CategoryNews(name: categoryName ?? ''),
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                "$image",
                width: 120,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 70,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Center(
                child: Text(
                  categoryName!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
