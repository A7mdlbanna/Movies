
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/shared/Network/end_points.dart';
import 'package:movies_app/shared/constants.dart';
import '../../models/Movies.dart';
import '../../models/Popular.dart';
import '../Network/remote/dio_helper.dart';
import 'app_states.dart';

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
    print(selectedCategory.length);
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
    selectedCategory = List.filled(10, false);
    selectedCategory[index] = true;
    // print(selectedCategory);
    emit(SelectCategory());
  }

  List<bool> favoriteActors = List.filled(10, false);
  void favActor(index){
    favoriteActors[index] = !favoriteActors[index];
    emit(SetFavActor());
  }
///////////////////////////HOME//////////////////////////////////

  // Movies? movies;
  // Future<void> getHomeData()async{
  //   emit(HomeLoadingState());
  //    DioHelper.getData(url: ,).then((value){
  //     // debugPrint(value);
  //      movies = Movies.fromJson(value?.data);
  //     emit(HomeSuccessfulState());
  //   }).catchError((error){
  //     debugPrint(error.toString());
  //     emit(HomeErrorState());
  //   });
  // }


  Popular? people;
  Future<void> getHomeData()async{
    emit(HomeLoadingState());
     DioHelper.getData(url: popular, query: {'api_key': apiKey, 'language' : 'en-US', 'page': 1,}).then((value){
      debugPrint(value.toString());
       people = Popular.fromJson(value?.data);
      emit(HomeSuccessfulState());
    }).catchError((error){
      debugPrint(error.toString());
      emit(HomeErrorState());
    });
  }

}