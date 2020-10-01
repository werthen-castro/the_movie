import 'dart:convert';

import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:the_movie/models/movie_model.dart';
import 'package:the_movie/utils/api_connector.dart';

import '../keys.dart';

class SearchMovieBloc{

  ApiConnector _apiConnector = ApiConnector();

  final _text = BehaviorSubject<String>();
  get text => _text.stream;

  final _offset = BehaviorSubject<int>.seeded(1);
  get offset => _offset.stream;

  final _movies = BehaviorSubject<List<Movie>>();
  get movies => _movies.stream;

  List<Movie> listMovies = [];

  Future<void> search() async {

    print("to aqui");

    try {

      Response response = await _apiConnector.apiGet(
          'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&language=en-US&query=${_text.value}&page=${_offset.value}&include_adult=false');
      Map body = json.decode(response.body);

      print(body);

      body['results'].forEach((element) {
        listMovies.add(Movie.fromMap(element) );
      });



      _movies.add(listMovies);

    } catch (e, s) {
      print(e);
      print(s);
    }
  }


}