import 'dart:convert';

import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:the_movie/models/movie_model.dart';
import 'package:the_movie/utils/api_connector.dart';

import '../keys.dart';

class DetailsMovieBloc{

  ApiConnector _apiConnector = ApiConnector();

  final _movie = BehaviorSubject<Movie>();
  get movie => _movie.stream;

  Future<void> getMovie(int movieId) async {

    try {

      Response response = await _apiConnector.apiGet(
          'https://api.themoviedb.org/3/movie/${movieId}?api_key=$apiKey&language=pt-BR');
      Map body = json.decode(response.body);

      _movie.add(Movie.fromMap(body['results']));
    } catch (e, s) {

    }
  }


}