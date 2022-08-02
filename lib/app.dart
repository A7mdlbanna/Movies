import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/helper/route_generator.dart';
import 'package:movies_app/ui/resources/app_routes.dart';
import 'package:movies_app/ui/resources/app_strings.dart';
import 'package:movies_app/ui/screens/home_screen.dart';

import 'core/cubit/cubit.dart';
import 'core/cubit/states.dart';
import 'ui/resources/app_strings.dart';

class MoviesApp extends StatelessWidget {
  const MoviesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getPopularData()
        ..getTrending(mediaType: 'all')
        ..getPopularMovies()
        ..getCategories(url: 'movie')
        ..getCategories(url: 'tv')
        ..getCategoryMovies(sorting: AppStrings.popularityDesc),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: AppStrings.appName,
              theme: ThemeData(
                  appBarTheme: const AppBarTheme(
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: Colors.transparent))),
              initialRoute: AppRoutes.splash,
              onGenerateRoute: RouteGenerator.generateRoute,
              home: const HomeScreen(),
            );
          }),
    );
  }
}
