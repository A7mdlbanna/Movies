import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/modules/info_screen.dart';
import 'package:movies_app/shared/Network/remote/dio_helper.dart';
import 'package:movies_app/shared/bloc_observer.dart';
import 'package:movies_app/shared/cubit/cubit.dart';
import 'package:movies_app/shared/cubit/states.dart';

import 'modules/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  BlocOverrides.runZoned(
        () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getPopularData()..getTrending(mediaType: 'all')..getPopularMovies()..getCategories(url: 'movie')..getCategories(url: 'tv')..getCategoryMovies(sorting: 'popularity.desc'),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              title: 'Movies App',
              theme: ThemeData(
                  appBarTheme: const AppBarTheme(
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: Colors.transparent
                      )
                  )
              ),
              initialRoute: '/',
              routes: {
                '/HomeScreen': (context) => const HomeScreen(),
                '/InfoScreen': (context) => const InfoScreen(),
              },
              home: const HomeScreen(),
            );
          }
      ),
    );
  }
}

