import 'package:flutter/material.dart';
import 'package:news_app/componets/custom_list_tile.dart';
import 'package:news_app/provider/article_provider.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import '../models/article_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ArticleProvider>.reactive(
      viewModelBuilder: () => ArticleProvider(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.lightGreenAccent,
            title: const Text(
              "News App",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          body: Consumer<ArticleProvider>(
            builder: (context, value, child) {
              if (value.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (value.error != null) {
                return Center(child: Text("Error: ${value.error}"));
              } else if (value.hasData) {
                List<Article> articles = value.articles!;
                return ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) =>
                      customListTile(articles[index], context),
                );
              } else {
                return const Center(
                  child: Text('No articles found.'),
                );
              }
            },
          ),
        );
      },
    );
  }
}
