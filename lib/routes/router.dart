import 'package:flutter/material.dart';
import 'package:movie_demo/pages/search_movie_home.dart';

import '../constants/route_constants.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const MovieSearchHome());

      default:
        return MaterialPageRoute(builder: (_) => const MovieSearchHome());
    }
  }
}
