
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/data/reopsitery/cast_and_crew_repo.dart';

import '../../core/models/Categories/MoviesCategories.dart' as movies_cat;
import '../../core/models/Categories/TvCategories.dart' as tv_cat;
import '../../core/models/Credits.dart';
import '../../core/models/People/PopularPeople.dart' as popular_people;
import '../../core/models/shows.dart' as show;
import '../constants.dart';
import '../data/dio/dio_helper.dart';
import '../data/dio/end_points.dart';
import 'states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);



  ///////////////App Bar//////////////////////////
  bool isPressedSearchIcon = false;
  void changeSearchIcon(){
    isPressedSearchIcon = !isPressedSearchIcon;
    emit(ChangeSearchIcon());
  }

  int dotIndex = 0;
  void changeDotIndex(index){
    // debugPrint(index.toString());
    dotIndex = index;
    emit(ChangeDotIndex());
  }

  double rating = 4.5;
  void changeRating(rating){
    this.rating = rating;
    emit(ChangeRating());
  }


  void selectCategory(index){
    selectedCategory = List.filled(20, false);
    selectedCategory[index] = true;
    // print(selectedCategory);
    emit(SelectCategory());
  }


  List<bool> selectedTrending = List.filled(4, false);
  void selectTrending(index){
    switch(index){
      case 0: getTrending(mediaType: 'all', timeWindow: timeWindow); break;
      case 1: getTrending(mediaType: 'movie', timeWindow: timeWindow); break;
      case 2: getTrending(mediaType: 'tv', timeWindow: timeWindow); break;
      case 3: getTrending(mediaType: 'person', timeWindow: timeWindow); break;
    }
    selectedTrending = List.filled(4, false);
    selectedTrending[index] = true;
    // print(selectedCategory);
    emit(SelectCategory());
  }
  List<bool> selectedTrendingDay = [false, true];
  void selectTrendingDay(index){
    switch(index){
      case 0: getTrending(mediaType: mediaType, timeWindow: 'day'); selectedTrendingDay[1] = false; break;
      case 1: getTrending(mediaType: mediaType, timeWindow: 'week'); selectedTrendingDay[0] = false; break;
    }
    selectedTrendingDay[index] = true;
    // print(selectedCategory);
    emit(SelectCategory());
  }


  List<bool> favTrendyActor = List.filled(20, false);
  void favTrendyPerson(index){
    favTrendyActor = List.filled(20, false);
    favTrendyActor[index] = !favoriteActors[index];
    emit(SetFavTrendyActor());
  }
  List<bool> favoriteActors = List.filled(20, false);
  void favActor(index){
    favoriteActors = List.filled(20, false);
    favoriteActors[index] = !favoriteActors[index];
    emit(SetFavActor());
  }
  late List<bool> favoriteMovieCast;
  void favMovieCast(index, size){
    favoriteMovieCast = List.filled(size, false);
    favoriteMovieCast[index] = !favoriteMovieCast[index];
    emit(SetFavActor());
  }
  late List<bool> favoriteMovieCrew;
  void favMovieCrew(index, size){
    favoriteMovieCrew = List.filled(size, false);
    favoriteMovieCrew[index] = !favoriteMovieCrew[index];
    emit(SetFavActor());
  }
  late List<bool> favoriteTvCast;
  void favTvCast(index, size){
    favoriteTvCast = List.filled(size, false);
    favoriteTvCast[index] = !favoriteTvCast[index];
    emit(SetFavActor());
  }
  late List<bool> favoriteTvCrew;
  void favTvCrew(index, size){
    favoriteTvCrew = List.filled(size, false);
    favoriteTvCrew[index] = !favoriteTvCrew[index];
    emit(SetFavActor());
  }


  List<bool> isPressedSort = List.filled(6, false);
  List<bool> isPressedDown = List.filled(6, false);
  void selectSort(index){
    bool flag = isPressedDown[index];
    isPressedSort = List.filled(6, false);
    isPressedDown = List.filled(6, false);
    isPressedSort[index] = !isPressedSort[index];
    isPressedDown[index] = !flag;
    emit(SelectSort());
  }


  String tvCats = '';
  String movieCats = '';
  String getCatName(show.Results info, int index){
    String? name;
    if(info.mediaType == 'movie') {
      for(int i = 0; i < moviesCategories.length; i++){
        if(moviesCategories[i].id == info.genreIds![index]) {
          name = moviesCategories[i].name;
          // emit(GetCatName());
        }
        }
      } else {
      for(int i = 0; i < tvCategories.length; i++){
        if(tvCategories[i].id == info.genreIds![index]) {
          name = tvCategories[i].name;
          // emit(GetCatName());
        }
      }
    }
    return name!;
  }

  String getCatsNames(show.Results info){
    String names = '';
    if(info.mediaType == 'movie') {
      for(int i = 0; i < info.genreIds!.length; i++){
        for(int j = 0; j < moviesCategories.length; j++){
          if(moviesCategories[j].id == info.genreIds![i]) {
            if(names != '') {
              names = '$names, ${moviesCategories[j].name}';
            } else {
              names = moviesCategories[j].name!;
            }
          }
        }
      }
    } else {
      for(int i = 0; i < info.genreIds!.length; i++){
        for(int j = 0; j < tvCategories.length; j++){
          if(tvCategories[j].id == info.genreIds![i]) {
            if(names != '') {
              names = '$names, ${tvCategories[j].name}';
            } else {
              names = tvCategories[j].name!;
            }
          }
        }
      }
    }
    return names;
  }


///////////////////////////API//////////////////////////////////

  List<show.Results> movies = [];
  show.Shows? popularMovies;
  Future<void> getPopularMovies({page = 1})async{
    emit(PopularMoviesLoadingState());
    DioHelper.getData(url: popular_Movies, query: {'api_key': apiKey,'page' : page}).then((value){
      // bigPrint(value.toString());
      popularMovies = show.Shows.fromJson(value?.data);
      movies.addAll(show.Shows.fromJson(value?.data).results!);
      emit(PopularMoviesSuccessfulState());
    }).catchError((error){
      debugPrint(error.toString());
      emit(PopularMoviesErrorState());
    });
  }


  late String mediaType;
  late String timeWindow;
  List<show.Results> shows = [];
  List<popular_people.Results> trendyPPL = [];
  dynamic trending;
  Future<void> getTrending({page = 1, required String mediaType, String timeWindow = 'week', bool changeCat = true,})async{
    emit(TrendingLoadingState());
    DioHelper.getData(url: 'trending/$mediaType/$timeWindow', query: {'api_key': apiKey,'page' : page}).then((value){
      // bigPrint(value.toString());
      this.mediaType = mediaType;
      this.timeWindow = timeWindow;
      if(mediaType != 'person') {
        isPerson = false;
        trending = show.Shows.fromJson(value?.data);
        if(changeCat)shows = [];
        shows.addAll(show.Shows.fromJson(value?.data).results!);
        emit(TrendingSuccessfulState());
      }
      else{
        isPerson = true;
        trending = popular_people.PopularPeople.fromJson(value?.data);
        if(changeCat)trendyPPL = [];
        trendyPPL.addAll(popular_people.PopularPeople.fromJson(value?.data).results!);
        emit(TrendingSuccessfulState());
      }
      shows.forEach((element) {print(element.title??element.name!);});
      // emit(TrendingSuccessfulState());
    }).catchError((error){
      debugPrint(error.toString());
      emit(TrendingErrorState());
    });
  }

  List<popular_people.Results> people = [];
  popular_people.PopularPeople? popularPeople;
  Future<void> getPopularData({page = 1})async{
    emit(PopularPeopleLoadingState());
     DioHelper.getData(url: popular_People, query: {'api_key': apiKey,'page' : page}).then((value){
      // debugPrint(value.toString());
      popularPeople = popular_people.PopularPeople.fromJson(value?.data);
      people.addAll(popularPeople!.results!);
      emit(PopularPeopleSuccessfulState());
    }).catchError((error){
      debugPrint(error.toString());
      emit(PopularPeopleErrorState());
    });
  }



///////////////////////////////////get movies of specific category/////////////////////////////////////
  show.Shows? categoryMovies;
  List<show.Results> catMovies = [];
  late String sorting = 'popularity.desc';
  late int category = 28;
  Future<void> getCategoryMovies({page = 1, category = 28, bool changeCat = true, required String sorting})async{
    emit(CategoryMoviesLoadingState());
    DioHelper.getData(url: 'discover/movie', query: {'api_key': apiKey,'page' : page, 'with_genres' : category, 'sort_by' : sorting}).then((value){
      this.sorting = sorting;
      this.category = category;
      // debugPrint(value.toString());
      categoryMovies = show.Shows.fromJson(value?.data);
      if(changeCat)catMovies = [];
      catMovies.addAll(categoryMovies!.results!);
      emit(CategoryMoviesSuccessfulState());
    }).catchError((error){
      debugPrint(error.toString());
      emit(CategoryMoviesErrorState());
    });
  }

  //////////////////////////////get categories//////////////////////////////////////////
  List<movies_cat.Genres> moviesCategories = [];
  List<tv_cat.Genres> tvCategories = [];
  Future<void> getCategories({required url})async{
    emit(MoviesCategoriesLoadingState());
    DioHelper.getData(url: 'genre/$url/list', query: {'api_key': apiKey,}).then((value){
      // debugPrint(value.toString());
      url == 'movie'
          ? moviesCategories = movies_cat.MoviesCategories.fromJson(value?.data).genres!
          : tvCategories = tv_cat.TvCategories.fromJson(value?.data).genres!;
      // debugPrint(popularPeople!.results!.length.toString());
      emit(MoviesCategoriesSuccessfulState());
    }).catchError((error){
      debugPrint(error.toString());
      emit(MoviesCategoriesErrorState());
    });
  }

  ///////////////////////get the cast and crew for a Movie///////////////////////////////
  // final CastRepo repo = CastRepo();

  Credits? movieCredits;
  List<Cast> movieCast = [];
  List<Crew> movieCrew = [];
  Future<void> getMovieCredits({required movieId})async{
    emit(MovieCreditsLoadingState());
      movieCredits = await CastRepo.Cast(movieId);
      movieCast = movieCredits!.cast!;
      movieCrew = movieCredits!.crew!;
      favoriteMovieCast = List.filled(movieCast.length, false);
      favoriteMovieCrew = List.filled(movieCrew.length, false);
      emit(MovieCreditsSuccessfulState());
  }
  ///////////////////////get the cast and crew for a TV Show///////////////////////////////
  Credits? tvCredits;
  List<Cast> tvCast = [];
  List<Crew> tvCrew = [];
  Future<void> getTvCredits({required tvId})async{
    emit(TvCreditsLoadingState());
      tvCredits = await CastRepo.Crew(tvId);
      // bigPrint(tvCredits!.toString());
      tvCast = tvCredits!.cast!;
      tvCrew = tvCredits!.crew!;
      favoriteTvCast = List.filled(tvCast.length, false);
      favoriteTvCrew = List.filled(tvCrew.length, false);
      emit(TvCreditsSuccessfulState());
  }
}