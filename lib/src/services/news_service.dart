import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_models.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _URL_API = 'https://newsapi.org/v2';
final _API_KEY = 'd4147b73df8e4a448d1eb47661d6b9f4';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';
  bool _isLoading = true;

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticle = {};

  NewsService() {
    this.getTopHeadlines();

    categories.forEach((item) {
      this.categoryArticle[item.name] = new List();
    });

    this.getArticlesByCategory(this._selectedCategory);
  }

  bool get isLoading => this._isLoading;

  get selectedCategory => this._selectedCategory;
  set selectedCategory(String value) {
    this._selectedCategory = value;
    this._isLoading = true;
    this.getArticlesByCategory(value);
    notifyListeners();
  }

  List<Article> get getArticlesByCategorySelected =>
      this.categoryArticle[this._selectedCategory];

  getTopHeadlines() async {
    final url = '$_URL_API/top-headlines?country=mx&apiKey=$_API_KEY';
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll(newsResponse.articles);

    notifyListeners();
  }

  getArticlesByCategory(String category) async {

    if (this.categoryArticle[category].length > 0) {
      this._isLoading = false;
      return this.categoryArticle[category];
    }

    final url =
        '$_URL_API/top-headlines?country=mx&category=$category&apiKey=$_API_KEY';
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    this.categoryArticle[category].addAll(newsResponse.articles);
    this._isLoading = false;
    notifyListeners();
  }
}
