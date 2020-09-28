import 'package:flutter/material.dart';
import 'package:the_movie/blocs/home_bloc.dart';
import 'package:the_movie/models/movie_model.dart';

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

  _card(Movie movie) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              urlBase + movie.posterPath,
              height: 150,
              width: 100,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.start,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        movie.overview,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                        maxLines: 6,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
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
                      return _card(snapshot.data[index]);
                    });
              }))
        );

  }
}
