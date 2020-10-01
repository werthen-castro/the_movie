import 'package:flutter/material.dart';
import 'package:the_movie/blocs/favorite_movies_bloc.dart';
import 'package:the_movie/helpers/movie_helper.dart';
import 'package:the_movie/models/movie_model.dart';
import 'package:the_movie/utils/app_colors.dart';

import '../keys.dart';

class MovieCard extends StatefulWidget {
  FavoriteMoviesBloc bloc;
  final Movie movie;

  MovieCard(this.movie, this.bloc);

  @override
  _MovieCardState createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  MovieHelper db = MovieHelper();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        color: AppColors.primaryColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            widget.movie.posterPath != null ? Image.network(
              urlBase + widget.movie.posterPath,
              height: 150,
              width: 100,
            ): Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Container(
                color: Colors.grey,
                height: 110,
                width: 75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info),
                    Text('Indisponivel', style: TextStyle(fontSize: 12),)
                  ],
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        widget.movie.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    //Icon(Icons.star),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        widget.movie.overview,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                        maxLines: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (!widget.movie.favorite) {
                  await widget.bloc.addMoviesFavorites(widget.movie);
                  //await db.insertMovie(widget.movie);
                } else {
                  await widget.bloc.deleteMoviesFavorites(widget.movie);
                  // await db.delete(widget.movie.id);
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
      ),
    );
  }
}
