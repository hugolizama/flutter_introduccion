
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../models/models.dart';
import 'package:peliculas/helpers/debouncer.dart';

class MoviesProvider extends ChangeNotifier{

  String _apiKey = '3385e2498ec69b33a8e4dd30c216f7d1';
  String _baseUrl = 'api.themoviedb.org';
  String _lenguage = 'es-MX';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  final debouncer = Debouncer(
    duration: Duration( milliseconds: 400 )
  );

  final StreamController<List<Movie>> _suggestionStreamController = new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => this._suggestionStreamController.stream;

  MoviesProvider(){
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsonData( String endpoint, [int page = 1] ) async{
    final url = Uri.https(this._baseUrl, endpoint, {
      'api_key': this._apiKey,
      'language': this._lenguage,
      'page': '$page',
    });

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async{
    
    final jsonData = await this._getJsonData('/3/movie/now_playing');    
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    this.onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }


  getPopularMovies() async {

    _popularPage++;

    final jsonData = await this._getJsonData('/3/movie/popular', _popularPage); 

    final popularResponse = PopularResponse.fromJson(jsonData);

    this.popularMovies = [...popularMovies, ...popularResponse.results];
    
    notifyListeners();
  }


  Future<List<Cast>> getMovieCast( int movieID ) async{

    if( this.moviesCast.containsKey( movieID ) ){
      return this.moviesCast[movieID]!;
    }

    final jsonData = await this._getJsonData('/3/movie/$movieID/credits');

    final creditsResponse = CreditsResponse.fromJson(jsonData);

    this.moviesCast[movieID] = creditsResponse.cast;

    return creditsResponse.cast;
  }


  Future<List<Movie>> searchMovie( String query ) async{
    final url = Uri.https(this._baseUrl, '/3/search/movie' , {
      'api_key': this._apiKey,
      'language': this._lenguage,
      'query': '$query',
      'page': '1',
      'include_adult': 'true',
    });

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }


  void getSuggestionsByQuery( String searchTerm ){
    debouncer.value = '';
    debouncer.onValue = ( value ) async {
      print('valor a buscar: $value');

      final results = await this.searchMovie( value );
      this._suggestionStreamController.add( results );
    };

    final timer = Timer.periodic(Duration(milliseconds: 200), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(Duration(milliseconds: 201)).then(( _ ) => timer.cancel());
  }

}