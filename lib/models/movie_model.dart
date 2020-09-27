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
    this.voteAverage
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      posterPath: map["poster_path"],
      adult: map["adult"],
      overview: map["overview"],
      releaseDate: DateTime.parse(map["release_date"]) ,
      genreIds: map["genre_ids"],
      id: map["id"],
      originalTitle:map["original_title"],
      originalLanguage:map["original_language"],
      title:map["title"],
      backdropPath:map["backdrop_path"],
      popularity:map["popularity"],
      voteCount:map["vote_count"],
      video:map["video"],
      voteAverage: map["vote_average"].toDouble()
    );
  }

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["poster_path"] = this.posterPath;
    map["adult"] = this.adult;
    map["overview"] = this.overview;
    map["release_date"] = this.releaseDate;
    map["genre_ids"] = this.genreIds;
    map["id"] = this.id;
    map["original_title"] = this.originalTitle;
    map["original_language"] = this.originalLanguage;
    map["title"] = this.title;
    map["backdrop_path"] = this.backdropPath;
    map["popularity"] = this.popularity;
    map["vote_count"] = this.voteCount;
    map["video"] = this.video;
    map["vote_average"] = this.voteAverage;

    return map;
  }








}

