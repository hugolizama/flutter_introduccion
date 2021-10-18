import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/src/models/models.dart';
import 'package:http/http.dart' as http;

class NewsService with ChangeNotifier{
  String _baseUrl = 'https://newsapi.org/v2';
  String _country = 'us';
  String _apiKey = '8f8b1d1cce024c819424d42fbc3e8bc0';
  String _selectedCategory = 'business';
  List<Article> headLines = [];
  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];
  Map<String, List<Article>> categoryArticles = {};

  NewsService(){
    this.getTopHeadlines();

    categories.forEach(( item ) {
      this.categoryArticles[item.name] = [];
    });

    this.getArticlesByCategory( this._selectedCategory );
  }

  String get selectedCategory => this._selectedCategory;
  set selectedCategory( String category ){
    this._selectedCategory = category;
    this.getArticlesByCategory(category);
    notifyListeners();
  }

  List<Article>? get getArticulosCategoriaSeleccionada => this.categoryArticles[this._selectedCategory];
  


  getTopHeadlines() async {
    final url = Uri.parse('${ this._baseUrl }/top-headlines?country=${ this._country }&apiKey=${ this._apiKey }');
    final resp = await http.get(url);

    final newsResponse = NewsResponse.fromJson( resp.body );

    this.headLines.addAll( newsResponse.articles );
    notifyListeners();
  }

  getArticlesByCategory( String category ) async{

    if( this.categoryArticles[category] != null && this.categoryArticles[category]!.length > 0 ){
      return this.categoryArticles[category];
    }


    final url = Uri.parse('${ this._baseUrl }/top-headlines?country=${ this._country }&category=${ category }&apiKey=${ this._apiKey }');
    final resp = await http.get(url);

    final newsResponse = NewsResponse.fromJson( resp.body );

    this.categoryArticles[category]!.addAll( newsResponse.articles ); 
    notifyListeners();   
  }
}