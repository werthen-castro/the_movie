class Movie{

  String posterPath;
  bool adult;
  String overview;
  DateTime releaseDate;
  List<dynamic> genreIds;
  int id;
  String originalTitle;
  String originalLanguage;
  String title;
  String backdropPath;
  double popularity;
  int voteCount;
  bool video;
  double voteAverage;
  bool favorite;

  Movie({
    this.posterPath,
    this.adult,
    this.overview,
    this.releaseDate,
    this.genreIds,
    this.id,
    this.originalTitle,
    this.originalLanguage,
    this.title,
    this.backdropPath,
    this.popularity,
    this.voteCount,
    this.video,
    this.voteAverage,
    this.favorite
  });

  factory Movie.fromMap(Map<String, dynamic> map, {bool favorite}) {
    return Movie(
      favorite: favorite == null ? map["favorite"] == null ? false :  map["favorite"] == 1 ? true : false : favorite,
      posterPath: map["poster_path"],
      adult: map["adult"] is bool ? map["adult"] : map["adult"] == 1 ? true : false,
      overview: map["overview"],
      id: map["id"],
      originalTitle:map["original_title"],
      originalLanguage:map["original_language"],
      title:map["title"],
      backdropPath:map["backdrop_path"],
      popularity:map["popularity"],
      voteCount:map["vote_count"],
      video: map["video"] is bool ? map["video"] : map["video"] == 1 ? true : false,
      voteAverage: map["vote_average"].toDouble()
    );
  }

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["favorite"] = this.favorite ? 1 : 0;
    map["poster_path"] = this.posterPath;
    map["adult"] = this.adult ? 1 :0;
    map["overview"] = this.overview;
    map["genre_ids"] = this.genreIds.toString();
    map["id"] = this.id;
    map["original_title"] = this.originalTitle;
    map["original_language"] = this.originalLanguage;
    map["title"] = this.title;
    map["backdrop_path"] = this.backdropPath;
    map["popularity"] = this.popularity;
    map["vote_count"] = this.voteCount;
    map["video"] = this.video ? 1 : 0;
    map["vote_average"] = this.voteAverage;

    return map;
  }








}

