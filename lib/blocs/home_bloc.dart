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

  getMoviesPopular() async {
    List<Movie> temp = [];

    try{
      Response response =  await _apiConnector.apiGet('https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=pt-BR&page=1');
      Map body  = json.decode(response.body) ;
      body['results'].forEach((element) {
        temp.add(Movie.fromMap(element) );
      });

      _movies.add(temp);
    }catch (e){

    }
  }
}