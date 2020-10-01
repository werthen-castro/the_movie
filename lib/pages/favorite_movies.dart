import 'package:flutter/material.dart';
import 'package:the_movie/blocs/favorite_movies_bloc.dart';
import 'package:the_movie/helpers/movie_helper.dart';
import 'package:the_movie/utils/app_colors.dart';
import 'package:the_movie/widgets/movie_card.dart';

class FavoriteMovies extends StatefulWidget {

  var favoriteBloc;

  FavoriteMovies(this.favoriteBloc);

  @override
  _FavoriteMoviesState createState() => _FavoriteMoviesState();
}

class _FavoriteMoviesState extends State<FavoriteMovies> {
  MovieHelper db = MovieHelper();

  @override
  void initState() {
    widget.favoriteBloc.getMoviesFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
        body: StreamBuilder(
            stream: widget.favoriteBloc.moviesFavorites,
            builder: (context, snapshot) {
              if (!snapshot.hasData )
                return Center(child: CircularProgressIndicator());
              return ListView.builder(
                 // controller: _scrollController,
                  padding: const EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MovieCard(snapshot.data[index], widget.favoriteBloc);
                  });
            }));
  }
}
