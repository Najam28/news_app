import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/pages/article_view.dart';

class AllNewsSection extends StatelessWidget {
  const AllNewsSection({
    super.key,
    required this.image,
    required this.description,
    required this.title,
    required this.url,
  });
  final String image, description, title, url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ArticleView(blogUrl: url),
        ));
      },
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              maxLines: 2,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(description, maxLines: 3),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
