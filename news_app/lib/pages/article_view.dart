import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  const ArticleView({super.key, required this.blogUrl});
  final String blogUrl;

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  @override
  void initState() {
    _controller.loadRequest(
      Uri.parse(widget.blogUrl),
    );
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    super.initState();
  }

  final WebViewController _controller = WebViewController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: RichText(
          text: TextSpan(
            text: 'World ',
            style: GoogleFonts.aboreto(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            children: [
              TextSpan(
                text: 'News',
                style: GoogleFonts.aboreto(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: WebViewWidget(
          controller: _controller
            ..loadRequest(
              Uri.parse(widget.blogUrl),
            ),
        ),
      ),
    );
  }
}
