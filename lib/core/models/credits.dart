class Credits {
  Credits({
      this.id, 
      this.cast, 
      this.crew,});

  Credits.fromJson(dynamic json) {
    id = json['id'];
    if (json['cast'] != null) {
      cast = [];
      // print(json['cast']);
      json['cast'].forEach((v) {
        cast?.add(Cast.fromJson(v));
      });
    }
    if (json['crew'] != null) {
      crew = [];
      // print(json['cast']);
      json['crew'].forEach((v) {
        crew?.add(Crew.fromJson(v));
      });
    }
  }
  int? id;
  List<Cast>? cast;
  List<Crew>? crew;
}

class Crew {
  Crew({
      this.adult, 
      this.gender, 
      this.id, 
      this.knownForDepartment, 
      this.name, 
      this.originalName, 
      this.popularity, 
      this.profilePath, 
      this.creditId, 
      this.department, 
      this.job,});

  Crew.fromJson(dynamic json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    originalName = json['original_name'];
    popularity = json['popularity'];
    if(json['profile_path'] != null)profilePath = 'https://image.tmdb.org/t/p/original${json['profile_path']}';
    creditId = json['credit_id'];
    department = json['department'];
    job = json['job'];
  }
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  String? creditId;
  String? department;
  String? job;

}

class Cast {
  Cast({
      this.adult, 
      this.gender, 
      this.id, 
      this.knownForDepartment, 
      this.name, 
      this.originalName, 
      this.popularity, 
      this.profilePath, 
      this.castId, 
      this.character, 
      this.creditId, 
      this.order,});

  Cast.fromJson(dynamic json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    originalName = json['original_name'];
    popularity = json['popularity'];
    if(json['profile_path'] != null)profilePath = 'https://image.tmdb.org/t/p/original${json['profile_path']}';
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    order = json['order'];
  }
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  int? castId;
  String? character;
  String? creditId;
  int? order;

}