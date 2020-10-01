import 'package:flutter/material.dart';
import 'package:the_movie/blocs/favorite_movies_bloc.dart';
import 'package:the_movie/blocs/popular_movies_bloc.dart';
import 'package:the_movie/widgets/movie_card.dart';

class PopularMovies extends StatefulWidget {
  @override
  _PopularMoviesState createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMovies> {

  ScrollController _scrollController = ScrollController();
  PopularMovieBloc _homeBloc = PopularMovieBloc();
  FavoriteMoviesBloc _favoriteMoviesBloc = FavoriteMoviesBloc();
  @override
  void initState() {
    _homeBloc.getMoviesPopular();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _homeBloc.getMoviesPopular();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _homeBloc.getMoviesPopular,
        child: StreamBuilder(
            stream: _homeBloc.movies,
            builder:
                (BuildContext context, snapshot) {
              if (snapshot.hasError) {}
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MovieCard(snapshot.data[index],_favoriteMoviesBloc);
                  });
            }));
  }
}
