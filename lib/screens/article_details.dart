import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';

class ArticlePage extends StatelessWidget {
  final Article article;
  const ArticlePage({required this.article,super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title ?? "",style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: article,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(article.urlToImage ?? ""),
                        fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.circular(8)
                ),
              ),
            ),
            SizedBox(height: 8,),
            Container(
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Text(article.source.name, style: TextStyle(color: Colors.white),),
            ),
            SizedBox(height: 8,),
            Text(article.description ?? "" ,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
          ],
        ),
      ),
    );
  }
}
