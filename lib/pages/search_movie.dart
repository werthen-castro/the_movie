import 'package:flutter/material.dart';
import 'package:the_movie/blocs/search_movie_bloc.dart';
import 'package:the_movie/utils/app_colors.dart';
import 'package:the_movie/widgets/movie_card.dart';


class SearchMovie extends StatefulWidget {

 var favoriteBloc;

 SearchMovie(this.favoriteBloc);

  @override
  _SearchMovieState createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  SearchMovieBloc _searchMovieBloc = SearchMovieBloc();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                  onTap: () {
                    _searchMovieBloc.text.add(_controller.text);
                    _searchMovieBloc.search();

                  },
                  child: Icon(Icons.search, color: Colors.white, size: 30)),
            )
          ],
          title: StreamBuilder(
            stream: _searchMovieBloc.text,
            builder: (context, snapshot) {
              return Container(
                height: 35,
                child: Center(
                  child: TextField(
                    autofocus: true,
                    style: TextStyle(color: Colors.white),
                    controller: _controller,
                    onChanged: (value) {
                     // _searchMovieBloc.text.add(value);
                    },
                    cursorColor: Colors.white,
                    decoration: new InputDecoration(

                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        hoverColor: Colors.white,
                        fillColor: AppColors.primaryColor,
                        focusColor: Colors.white,
                        hintText: 'Pesquise aqui',
                        hintStyle: TextStyle(color: Colors.white)),
                    onSubmitted: (x) {
                      _searchMovieBloc.search();
                    },
                  ),
                ),
              );
            }
          ),
        ),
        body: StreamBuilder<Object>(
          stream: _searchMovieBloc.text,
          builder: (context, snapText) {
            return StreamBuilder(
                stream: _searchMovieBloc.movies,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasError) {}
                  if (!snapshot.hasData && snapText.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: !snapText.hasData ?  0 : snapshot.data?.length ,
                      itemBuilder: (BuildContext context, int index) {
                        return MovieCard(snapshot.data[index], widget.favoriteBloc);
                      });
                });
          }
        ));
  }
}
