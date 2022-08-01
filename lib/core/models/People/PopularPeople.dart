
class PopularPeople {
  PopularPeople({
      this.page, 
      this.results, 
      this.totalResults, 
      this.totalPages,});

  PopularPeople.fromJson(dynamic json) {
    page = json['page'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
  }
  int? page;
  List<Results>? results;
  int? totalResults;
  int? totalPages;

  // Map<String, dynamic> toJson() {
  //   final map = <String, dynamic>{};
  //   map['page'] = page;
  //   if (results != null) {
  //     map['results'] = results?.map((v) => v.toJson()).toList();
  //   }
  //   map['total_results'] = totalResults;
  //   map['total_pages'] = totalPages;
  //   return map;
  // }

}

class Results {
  Results({
      this.profilePath,
      this.adult, 
      this.id, 
      this.knownFor, 
      this.name, 
      this.popularity,});

  Results.fromJson(dynamic json) {
    if(json['profile_path'] != null)profilePath = 'https://image.tmdb.org/t/p/original${json['profile_path']}';
    // debugPrint(profilePath.toString());
    adult = json['adult'];
    id = json['id'];
    if (json['known_for'] != null) {
      knownFor = [];
      json['known_for'].forEach((v) {
        knownFor?.add(KnownFor.fromJson(v));
      });
    }
    name = json['name'];
    popularity = json['popularity'];
  }
  String? profilePath;
  bool? adult;
  int? id;
  List<KnownFor>? knownFor;
  String? name;
  dynamic popularity;
}

class KnownFor {
  KnownFor({
      this.posterPath, 
      this.adult, 
      this.overview, 
      this.releaseDate, 
      this.originalTitle, 
      this.genreIds, 
      this.id, 
      this.mediaType, 
      this.originalLanguage, 
      this.title, 
      this.backdropPath, 
      this.popularity, 
      this.voteCount, 
      this.video, 
      this.voteAverage,});

  KnownFor.fromJson(dynamic json) {
    if(json['poster_path'] != null)posterPath = 'https://image.tmdb.org/t/p/original${json['poster_path']}';
    adult = json['adult'];
    overview = json['overview'];
    releaseDate = json['release_date'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'] != null ? json['genre_ids'].cast<int>() : [];
    id = json['id'];
    mediaType = json['media_type'];
    originalLanguage = json['original_language'];
    title = json['title'];
    backdropPath = json['backdrop_path'];
    popularity = json['popularity'];
    voteCount = json['vote_count'];
    video = json['video'];
    voteAverage = json['vote_average'];
  }
  String? posterPath;
  bool? adult;
  String? overview;
  String? releaseDate;
  String? originalTitle;
  List<int>? genreIds;
  int? id;
  String? mediaType;
  String? originalLanguage;
  String? title;
  String? backdropPath;
  dynamic popularity;
  int? voteCount;
  bool? video;
  dynamic voteAverage;
}