import 'package:flutter/material.dart';
import '../modals/articles.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class FilterOptions {
  String filterName;
  bool isActive;
  FilterOptions(this.filterName, this.isActive);
}

class ProviderData extends ChangeNotifier {
  final List<FilterOptions> _horizontalFilters = [
    FilterOptions('All', true),
    FilterOptions('Business', false),
    FilterOptions('Gadgets', false),
    FilterOptions('Sport', false),
    FilterOptions('Video', false)
  ];
  List<FilterOptions> get horizFilterList {
    return _horizontalFilters;
  }

  List<Articles> _articleList = [];
  int commentsInNews = 34;
  int views = 50;

  List<Articles> get articleList {
    return _articleList;
  }

  List<Articles> _fetchedArticlesList = [];

  List<Articles> get fetchedArticles {
    return _fetchedArticlesList;
  }

  int currentIndex = 0;
  Future<void> addArticle(Articles articles) async {
    final url = Uri.parse(
        'https://news-app-c173e-default-rtdb.firebaseio.com/articles.json');
    try {
      final time = DateFormat.yMMMd().format(DateTime.now());

      final response =
          await http.post(url, body: json.encode(Articles.toJson(articles)));
      final newArticle = Articles(
          title: articles.title,
          authorName: articles.authorName,
          description: articles.description,
          dateTime: time,
          imageUrl: articles.imageUrl);
      _articleList.add(newArticle);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchArticles() async {
    final url = Uri.parse(
        'https://news-app-c173e-default-rtdb.firebaseio.com/articles.json');
    final response = await http.get(url);

    final List<Articles> _list = [];
    final fetchedArticles =
        await jsonDecode(response.body) as Map<String, dynamic>?;
    if (fetchedArticles == null) {
      return;
    }

    fetchedArticles.forEach((key, value) {
      _list.add(Articles.fromJson(value));
    });
    _fetchedArticlesList = _list;
    notifyListeners();
  }

  void toggleFilterOptions(int index) {
    _horizontalFilters[index].isActive = !_horizontalFilters[index].isActive;
    notifyListeners();
  }
}
