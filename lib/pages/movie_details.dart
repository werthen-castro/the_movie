import 'package:flutter/material.dart';
import 'package:the_movie/helpers/movie_helper.dart';
import 'package:the_movie/models/movie_model.dart';
import 'package:the_movie/utils/app_colors.dart';

import '../keys.dart';

class MovieDetails extends StatefulWidget {

  final Movie movie;
  var bloc;

  MovieDetails(this.movie, this.bloc);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {

  MovieHelper db = MovieHelper();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(widget.movie.title),
        actions: [
          GestureDetector(
            onTap: () async {
              if (!widget.movie.favorite) {
                await widget.bloc.addMoviesFavorites(widget.movie);
              } else {
                await widget.bloc.deleteMoviesFavorites(widget.movie);
              }

              setState(() {
                widget.movie.favorite = !widget.movie.favorite;
              });

              await db.update(widget.movie);
            },
            child: Padding(
                padding: const EdgeInsets.only(top: 8, right: 8),
                child: widget.movie.favorite
                    ? Icon(Icons.star,size: 30, color: Colors.yellow, )
                    : Icon(Icons.star_border, size: 30, color: Colors.grey)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              urlBase + widget.movie.backdropPath,
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20, left: 8, right: 8, bottom: 20),
              child: Text("Título do filme:  "+widget.movie.title, style: TextStyle(color: Colors.white, fontSize: 20),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Quantidade de avalições: "+widget.movie.voteCount.toString(), style: TextStyle(color: Colors.white)),
                  Text("Nota: "+widget.movie.voteAverage.toString(), style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Resumo: " + widget.movie.overview, style: TextStyle(color: Colors.white), textAlign: TextAlign.justify,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Adulto: " + widget.movie.adult.toString(), style: TextStyle(color: Colors.white)),
            ),

          ],
        ),
      ),
    );
  }
}
