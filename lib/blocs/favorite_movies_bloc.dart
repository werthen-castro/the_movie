import 'package:rxdart/rxdart.dart';
import 'package:the_movie/helpers/movie_helper.dart';
import 'package:the_movie/models/movie_model.dart';

class FavoriteMoviesBloc {

  final _moviesFavorites = BehaviorSubject<List<Movie>>();
  get moviesFavorites => _moviesFavorites.stream;

  MovieHelper movieHelper = MovieHelper();

  addMoviesFavorites(Movie movie) async {
    List<Movie>  movies =  await movieHelper.insertMovie(movie);
    _moviesFavorites.add(movies);
  }

  getMoviesFavorites() async {
    List<Movie>  movies =  await movieHelper.getMovies();
    _moviesFavorites.add(movies);
  }

  deleteMoviesFavorites(Movie movie) async {
    await movieHelper.delete(movie.id);
    List<Movie>  movies = await movieHelper.getMovies();
    _moviesFavorites.add(movies);
  }

  dispose(){
    _moviesFavorites.close();
  }
}