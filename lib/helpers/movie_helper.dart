import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:the_movie/models/movie_model.dart';

class MovieHelper {

  final String tableMovies = 'Movies';
  final String columnId = 'id';
  final String columnTitle  = "title";
  final String columnOverview = "overview";
  final String columnFavorite = "favorite" ;
  final String columnAdult  = "adult" ;
  final String columnPoster_path = "poster_path" ;
  final String columnRelease_date = "release_date";
  final String columnOriginal_title = "original_title";
  final String columnOriginal_language = "original_language";
  final String columnBackdrop_path = "backdrop_path";
  final String columnGenre_ids = "genre_ids";
  final String columnPopularity = "popularity";
  final String columnVote_count = "vote_count";
  final String columnVideo = "video";
  final String columnVote_average = "vote_average";

  static final MovieHelper _movieHelper = MovieHelper._internal();
  Database _db;
  factory MovieHelper(){
    return _movieHelper;
  }

  MovieHelper._internal();

  get db async {
    if( _db != null ){
      return _db;
    }else{
      _db = await initDB();
      return _db;
    }
  }

  _onCreate(Database db, int version) async {
    String sql = "CREATE TABLE $tableMovies ("
        "$columnId INTERGER PRIMARY KEY,"
        "$columnTitle VARCHAR,"
        "$columnOverview VARCHAR,"
        "$columnFavorite INTEGER ,"
        "$columnAdult INTEGER,"
        "$columnPoster_path VARCHAR,"
        "$columnRelease_date VARCHAR,"
        "$columnOriginal_title VARCHAR,"
        "$columnOriginal_language VARCHAR,"
        "$columnBackdrop_path VARCHAR,"
        "$columnGenre_ids VARCHAR,"
        "$columnPopularity REAL,"
        "$columnVote_count INTEGER,"
        "$columnVideo INTEGER,"
        "$columnVote_average INTEGER)";
    await db.execute(sql);

  }

  initDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "database_movies.db");
    Database db = await openDatabase(localBancoDados, version: 1, onCreate: _onCreate );

    return db;
  }

  Future insertMovie(Movie movie) async {
    Database dbClient = await db;

    try{
      await dbClient.insert(tableMovies, movie.toMap());
    }catch (e){
    }
  }

  Future<int> delete(int id) async {
    Database dbClient = await db;
    return await dbClient.delete(tableMovies, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Movie movie) async {
    Database dbClient = await db;
    return await dbClient.update(tableMovies, movie.toMap(),
        where: '$columnId = ?', whereArgs: [movie.id]);
  }

  Future getIds( ) async {
    var dbClient = await db;
    List<int> list = [];

    List<Map> maps  = await dbClient.rawQuery('SELECT $columnId FROM $tableMovies');

    maps.forEach((element) {
      list.add(element['$columnId']);
    });

    return list ;
  }

  Future<List<Movie>> getMovies() async {
    var dbClient = await db;
    List<Movie> list;

    try{
      List<Map> maps = await dbClient.rawQuery('SELECT * FROM $tableMovies');

     list = maps.map((item) {
        return Movie.fromMap(item);
      }).toList();
    }catch (e, s){

    }


    return list ;
  }
}










