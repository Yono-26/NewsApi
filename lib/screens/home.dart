import 'package:flutter/material.dart';
import 'package:news_app/componets/custom_list_tile.dart';
import 'package:news_app/services/api_service.dart';

import '../models/article_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService client = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        title: Text(
          "News App",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: FutureBuilder(
          future: client.getArticle(),
          builder:
              (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  List<Article> articles = snapshot.data!;
                  return ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) => customListTile(articles[index], context)
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
