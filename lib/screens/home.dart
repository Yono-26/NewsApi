import 'package:flutter/material.dart';
import 'package:news_app/componets/custom_list_tile.dart';
import 'package:news_app/provider/article_provider.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  void _performSearch(ArticleProvider viewModel) {
    final query = _searchController.text.trim();

    if (query.isNotEmpty && query.length >= 3) {
      viewModel.fetchArticleByQuery(query);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please enter atleast 3 numbers to search"),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ArticleProvider>.reactive(
      onViewModelReady: (viewModel) => viewModel.fetchRecentNews(),
      viewModelBuilder: () => ArticleProvider(),
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
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  onTapOutside: (e) => FocusScope.of(context).unfocus(),
                  controller: _searchController,
                  onChanged: (text) => viewModel.updateSearchText(text),
                  onFieldSubmitted: (_) => _performSearch(viewModel),
                  decoration: InputDecoration(
                      hintText: "Search news...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: viewModel.isCloseIcon
                          ? IconButton(
                              onPressed: () {
                                _searchController.clear();
                                viewModel.closeSearch();
                              },
                              icon: Icon(Icons.close))
                          : IconButton(
                              onPressed: () => _performSearch(viewModel),
                              icon: Icon(Icons.search))),
                ),
              ),
              Expanded(
                child: Builder(
                  builder: (_) {
                    if (viewModel.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (viewModel.error != null) {
                      return Center(child: Text("Error: ${viewModel.error}"));
                    } else if (viewModel.filteredArticles != null &&
                        viewModel.filteredArticles!.isNotEmpty) {
                      return ListView.builder(
                        itemCount: viewModel.filteredArticles!.length,
                        itemBuilder: (context, index) => customListTile(
                          viewModel.filteredArticles![index],
                          context,
                        ),
                      );
                    } else {
                      return const Center(
                          child: Text('Search for news articles'));
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
