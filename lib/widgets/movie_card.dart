import 'package:flutter/material.dart';
import 'package:the_movie/models/movie_model.dart';

import '../keys.dart';

class MovieCard extends StatelessWidget {

  final Movie movie;

  MovieCard(this.movie);

  @override
  Widget build(BuildContext context) {
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
}
