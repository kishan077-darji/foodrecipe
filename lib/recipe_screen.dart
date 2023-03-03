import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeScreen extends StatefulWidget {
  final String url;

  const RecipeScreen({super.key, required this.url});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  String? finalUrl;

  late final WebViewController controller;

  @override
  void initState() {
    if (widget.url.contains("http://")) {
      finalUrl = widget.url.replaceAll("http://", "https://");
    } else {
      finalUrl = widget.url;
    }
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(finalUrl.toString()),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe'),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
