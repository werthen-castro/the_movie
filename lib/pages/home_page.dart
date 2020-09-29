import 'package:flutter/material.dart';
import 'package:the_movie/blocs/home_bloc.dart';
import 'package:the_movie/models/movie_model.dart';
import 'package:the_movie/widgets/movie_card.dart';

import '../keys.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = ScrollController();
  HomeBloc _homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
          _homeBloc.getMoviesPopular();
      }
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('The Movie'),
        ),
        body:  RefreshIndicator(
            onRefresh: _homeBloc.getMoviesPopular,
            child: StreamBuilder<List<Movie>>(
              stream: _homeBloc.movies,

              builder: (BuildContext context, AsyncSnapshot<List<Movie>>  snapshot) {
                if (snapshot.hasError) {

                }
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MovieCard(snapshot.data[index]);
                    });
              }))
        );

  }
}
