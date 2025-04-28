import 'package:flutter/material.dart';
import 'package:news_app/componets/custom_list_tile.dart';
import 'package:news_app/provider/article_provider.dart';
import 'package:stacked/stacked.dart';
import '../models/article_model.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? _debounce;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ArticleProvider>.reactive(
      viewModelBuilder: () => ArticleProvider(),
      onViewModelReady: (viewModel) => viewModel.fetchArticleByQuery('apple'),
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
          body: viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : viewModel.error != null
              ? Center(child: Text("Error: ${viewModel.error}"))
              : viewModel.hasData
              ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  onChanged: (searchedText) {
                    _onSearchChanged(searchedText, viewModel);
                  },
                  decoration: InputDecoration(
                    hintText: "Search news...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: viewModel.filteredArticles!.isNotEmpty
                    ? ListView.builder(
                  itemCount: viewModel.filteredArticles!.length,
                  itemBuilder: (context, index) => customListTile(
                    viewModel.filteredArticles![index],
                    context,
                  ),
                )
                    : const Center(child: Text('No articles found.')),
              ),
            ],
          )
              : const Center(
            child: Text('No articles available.'),
          ),
        );
      },
    );
  }

  void _onSearchChanged(String query, ArticleProvider viewModel) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 1000), () {
      if (query.isNotEmpty) {
        viewModel.fetchArticleByQuery(query);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}