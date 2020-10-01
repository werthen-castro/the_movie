import 'package:flutter/material.dart';

import 'package:the_movie/widgets/movie_card.dart';

class PopularMovies extends StatefulWidget {

  var homeBloc;
  var favoriteMoviesBloc;
  PopularMovies(this.homeBloc, this.favoriteMoviesBloc);
  @override
  _PopularMoviesState createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMovies> {

  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        widget.homeBloc.getMoviesPopular();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: widget.homeBloc.getMoviesPopular,
        child: StreamBuilder(
            stream: widget.homeBloc.movies,
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
                    return MovieCard(snapshot.data[index], widget.favoriteMoviesBloc);
                  });
            }));
  }
}
