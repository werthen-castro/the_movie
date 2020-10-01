import 'package:flutter/material.dart';
import 'package:the_movie/blocs/favorite_movies_bloc.dart';
import 'package:the_movie/blocs/popular_movies_bloc.dart';
import 'package:the_movie/helpers/movie_helper.dart';
import 'package:the_movie/pages/popular_movies.dart';
import 'package:the_movie/pages/search_movie.dart';
import 'package:the_movie/utils/app_colors.dart';
import 'favorite_movies.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  MovieHelper db = MovieHelper ();
  static PopularMovieBloc _homeBloc = PopularMovieBloc();
  static FavoriteMoviesBloc _favoriteMoviesBloc = FavoriteMoviesBloc();

  List<Widget> _widgetOptions = <Widget>[
    PopularMovies(_homeBloc, _favoriteMoviesBloc),
    FavoriteMovies(_favoriteMoviesBloc),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text('The Movie'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                  child: Icon(Icons.search, color: Colors.white, size: 30),
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => SearchMovie(_favoriteMoviesBloc)),
                  );
                },
              ),
            )
          ],
        ),
        body:  _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.primaryColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Favoritos'),
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: AppColors.grayLight,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
        );

  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
