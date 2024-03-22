import 'dart:async';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/cast.dart';
import 'package:peliculas/models/credits.dart';
import 'package:peliculas/models/movies.dart';
import 'package:peliculas/models/now_playing_responde.dart';
import 'package:peliculas/models/search_Response.dart';
import 'package:peliculas/models/search_movie.dart';

class MoviesProvider extends ChangeNotifier {
  String _apiKey =
      'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzNmI3NWRmZTU4YmIzN2NhMzRj' +
          'YWI4NjQ5MDQzM2I3ZiIsInN1YiI6IjY1ZDY3OWU0MjVjZDg1MDE4NjdlZGQxNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.' +
          '8h1OoRUh1lhypxHbtIinXAvvYDhPWxV_JBFvLBbTtiY';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';
  String _page = '1';
  List<Movie> onDisplayMovie = [];
  Map<int, List<Cast>> memory = {};

  StreamController<List<SearchMovie>> streamController =
      StreamController.broadcast();
  Stream<List<SearchMovie>> get streamC => streamController.stream;
  MoviesProvider() {
    this.getOnDisplayMovies();
  }
  getOnDisplayMovies() async {
    try {
      var url =
          Uri.https(_baseUrl, '3/movie/now_playing', {'language': _language});
      var response = await http.get(url,
          headers: {'Authorization': _apiKey, 'acept': 'application/json'});
      //   final Map<String, dynamic> decodeResponse = json.decode(response.body);
      final nowPlayingResponde = NowPlayingResponse.fromRawJson(response.body);
      onDisplayMovie = nowPlayingResponde.results;
      notifyListeners();
    } catch (Exception) {
      print("error : $Exception");
    }
  }

  Future getCredits(int movie_id) async {
    if (memory.containsKey(movie_id)) {
      print('estamso aca ahora');
      return memory[movie_id];
    }

    final url = Uri.https(
        _baseUrl, '3/movie/${movie_id}/credits', {'language': _language});

    var response = await http.get(url,
        headers: {'Authorization': _apiKey, 'acept': 'application/json'});
    //   final Map<String, dynamic> decodeResponse = json.decode(response.body);
    Credits credits = Credits.fromRawJson(response.body);
    memory[movie_id] = credits.cast;
    // List<Cast> onDisplayCredits = [...credits.cast];
    return credits.cast;
  }

  Future<List<SearchMovie>> getSearchMovie(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie',
        {'language': _language, 'page': _page, 'query': query});
    var response = await http.get(url,
        headers: {'Authorization': _apiKey, 'acept': 'application/json'});
    SearchResponse searchMovie = SearchResponse.fromRawJson(response.body);
    return searchMovie.results;
  }

  getSuggestionSearch(String searchTerm) {
    EasyDebounce.debounce('mi primer debounce', Duration(milliseconds: 500),
        () async {
      List<SearchMovie> a = await getSearchMovie(searchTerm);
      streamController.sink.add(a);
    });
  }
}
