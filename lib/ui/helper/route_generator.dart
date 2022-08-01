import 'package:flutter/material.dart';
import 'package:movies_app/ui/resources/app_routes.dart';
import 'package:movies_app/ui/screens/actor_info_screen.dart';
import 'package:movies_app/ui/screens/home_screen.dart';
import 'package:movies_app/ui/screens/movie_info_screen.dart';

class RouteGenerator{
  static Route? generateRoute(RouteSettings settings){
    final dynamic args = settings.arguments;

    switch (settings.name){

      // case AppRoutes.splash:
      //   return _screenRedirect(SplashScreen());

      case AppRoutes.home:
        return _screenRedirect(const HomeScreen());

      case AppRoutes.movieInfo:
        return _screenRedirect(const MovieInfoScreen());

      case AppRoutes.actorInfo:
        return _screenRedirect(const ActorInfoScreen());

      default:
        return _errorRoute();

    }
  }
  static MaterialPageRoute<dynamic> _screenRedirect(Widget screen) {
    return MaterialPageRoute<dynamic>(builder: (_) => screen);
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
