import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/cubit/bloc_observer.dart';
import 'package:movies_app/core/data/dio/dio_helper.dart';
import 'package:movies_app/ui/screens/movie_info_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  BlocOverrides.runZoned(
        () {
      runApp(const MovieInfoScreen());
    },
    blocObserver: MyBlocObserver(),
  );
}