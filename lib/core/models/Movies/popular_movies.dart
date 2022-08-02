// class PopularMovies {
//   PopularMovies({
//       this.page,
//       this.results,
//       this.totalPages,
//       this.totalResults,});
//
//   PopularMovies.fromJson(dynamic json) {
//     page = json['page'];
//     if (json['results'] != null) {
//       results = [];
//       json['results'].forEach((v) {
//         results?.add(Results.fromJson(v));
//       });
//     }
//     totalPages = json['total_pages'];
//     totalResults = json['total_results'];
//   }
//   int? page;
//   List<Results>? results;
//   int? totalPages;
//   int? totalResults;
// }
//
// class Results {
//   Results({
//       this.adult,
//       this.backdropPath,
//       this.genreIds,
//       this.id,
//       this.originalLanguage,
//       this.originalTitle,
//       this.originalName,
//       this.overview,
//       this.popularity,
//       this.posterPath,
//       this.releaseDate,
//       this.title,
//       this.name,
//       this.video,
//       this.voteAverage,
//       this.voteCount,});
//
//   Results.fromJson(dynamic json) {
//     adult = json['adult'];
//     if(json['backdrop_path'] != null)backdropPath = backdropPath! + json['backdrop_path'];
//     genreIds = json['genre_ids'] != null ? json['genre_ids'].cast<int>() : [];
//     id = json['id'];
//     originalLanguage = json['original_language'];
//     originalName = json['original_name'];
//     originalTitle = json['original_title'];
//     overview = json['overview'];
//     popularity = json['popularity'];
//     if(json['poster_path'] != null)posterPath = posterPath! + json['poster_path'];
//     releaseDate = json['release_date'];
//     name = json['name'];
//     title = json['title'];
//     video = json['video'];
//     voteAverage = json['vote_average'];
//     voteCount = json['vote_count'];
//   }
//   bool? adult;
//   String? backdropPath = 'https://image.tmdb.org/t/p/original';
//   List<int>? genreIds;
//   int? id;
//   String? originalLanguage;
//   String? originalName;
//   String? originalTitle;
//   String? overview;
//   dynamic popularity;
//   String? posterPath = 'https://image.tmdb.org/t/p/original';
//   String? releaseDate;
//   String? name;
//   String? title;
//   bool? video;
//   dynamic voteAverage;
//   int? voteCount;
//
// }