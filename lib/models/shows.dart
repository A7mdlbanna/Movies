import 'package:flutter/cupertino.dart';

class Shows {
  Shows({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,});

  Shows.fromJson(dynamic json) {
    page = json['page'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
  int? page;
  List<Results>? results = [];
  int? totalPages;
  int? totalResults;
}

class Results {
  Results({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalName,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.firstAirDate,
    this.title,
    this.name,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.popularity,});

  Results.fromJson(dynamic json) {
    adult = json['adult'];
    if(json['backdrop_path'] != null)backdropPath = 'https://image.tmdb.org/t/p/original${json['backdrop_path']}';
    // debugPrint('backDrop: $backdropPath');
    genreIds = json['genre_ids'] != null ? json['genre_ids'].cast<int>() : [];
    id = json['id'];
    originalLanguage = json['original_language'];
    originalName = json['original_name'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    if(json['poster_path'] != null)posterPath = 'https://image.tmdb.org/t/p/original${json['poster_path']}';
    // debugPrint('poster: $posterPath');
    releaseDate = json['release_date'];
    firstAirDate = json['first_air_date'];
    title = json['title'];
    name = json['name'];
    video = json['video'];
    voteAverage = json['vote_average'];
    if(voteAverage is! double)voteAverage = voteAverage + 0.0;
    voteCount = json['vote_count'];
    popularity = json['popularity'];
  }
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? releaseDate;
  String? firstAirDate;
  String? title;
  String? name;
  String? originalName;
  bool? video;
  dynamic voteAverage;
  int? voteCount;
  dynamic popularity;
}