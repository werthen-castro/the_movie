import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:the_movie/helpers/movie_helper.dart';
import 'package:the_movie/models/movie_model.dart';
import 'package:the_movie/utils/api_connector.dart';

import '../config.dart';

class PopularMovieBloc {

  PopularMovieBloc(){
    getMoviesPopular();
  }

  ApiConnector _apiConnector = ApiConnector();

  final _movies = BehaviorSubject<List<Movie>>();
  get movies => _movies.stream;

  final _offset = BehaviorSubject<int>.seeded(1);
  get offset => _offset.stream;

  List<Movie> listMovies = [];
  MovieHelper _movieHelper = MovieHelper();


  Future<void> getMoviesPopular() async {

    try {
      var array = await _movieHelper.getIds();

      Response response = await _apiConnector.apiGet(
          'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=pt-BR&page=${_offset
              .value}');
      Map body = json.decode(response.body);
      for(int i = 0, j = 0; i < body['results'].length;i ++, j++){

        if(array.contains(body['results'][i]['id'] )){
          listMovies.add(Movie.fromMap(body['results'][i], favorite: true));
        }else{
          listMovies.add(Movie.fromMap(body['results'][i]));
        }
      }

      _movies.add(listMovies);
      _offset.add(_offset.value + 1);
    } catch (e, s) {

    }
  }

  dispose(){
    _movies.close();
    _offset.close();
  }
}