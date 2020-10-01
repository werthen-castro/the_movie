import 'package:flutter/material.dart';
import 'package:the_movie/blocs/favorite_movies_bloc.dart';
import 'package:the_movie/helpers/movie_helper.dart';
import 'package:the_movie/widgets/movie_card.dart';

class FavoriteMovies extends StatefulWidget {
  @override
  _FavoriteMoviesState createState() => _FavoriteMoviesState();
}

class _FavoriteMoviesState extends State<FavoriteMovies> {
  MovieHelper db = MovieHelper();
  FavoriteMoviesBloc _favoriteBloc = FavoriteMoviesBloc();

  @override
  void initState() {
    _favoriteBloc.getMoviesFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: _favoriteBloc.moviesFavorites,
            builder: (context, snapshot) {
              if (!snapshot.hasData )
                return Center(child: CircularProgressIndicator());
              return ListView.builder(
                 // controller: _scrollController,
                  padding: const EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MovieCard(snapshot.data[index], _favoriteBloc);
                  });
            }));
  }
}
