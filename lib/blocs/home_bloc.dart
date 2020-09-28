import 'dart:convert';

import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:the_movie/models/movie_model.dart';
import 'package:the_movie/utils/api_connector.dart';

import '../keys.dart';

class HomeBloc {

  HomeBloc(){
    getMoviesPopular();
  }

  ApiConnector _apiConnector = ApiConnector();

  final _movies = BehaviorSubject<List<Movie>>();
  get movies => _movies.stream;

  final _offset = BehaviorSubject<int>.seeded(1);
  get offset => _offset.stream;
  List<Movie> temp = [];

  Future<void> getMoviesPopular() async {

    try{
      Response response =  await _apiConnector.apiGet('https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=pt-BR&page=${_offset.value}');
      Map body  = json.decode(response.body) ;
      body['results'].forEach((element) {
        temp.add (Movie.fromMap(element) );
      });

      _movies.add(temp);
      _offset.add(_offset.value + 1);
    }catch (e){

    }
  }

  dispose(){
    _movies.close();
    _offset.close();
  }
}