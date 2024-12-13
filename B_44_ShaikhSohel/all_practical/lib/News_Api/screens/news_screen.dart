import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/article.dart';
import '../widgets/category_drawer.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final ApiService apiService = ApiService();
  List<Article> articles = [];
  String selectedCategory = 'general';

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    try {
      final fetchedArticles = await apiService.fetchArticles(selectedCategory);
      setState(() {
        articles = fetchedArticles;
      });
    } catch (error) {
      // Handle error (e.g., show a Snackbar)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News App')),
      drawer: CategoryDrawer(
        onCategorySelected: (category) {
          setState(() {
            selectedCategory = category;
          });
          fetchArticles();
        },
      ),
      body: articles.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return ListTile(
            title: Text(article.title),
            subtitle: Text(article.description ?? ''),
            leading: article.urlToImage != null
                ? Image.network(article.urlToImage, width: 100, fit: BoxFit.cover)
                : null,
            onTap: () {
              // Handle article tap (e.g., navigate to a web view)
            },
          );
        },
      ),
    );
  }
}
