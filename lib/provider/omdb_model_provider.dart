import 'package:flutter/material.dart';
import 'package:movie_demo/model/omdb.model.dart';
import 'package:movie_demo/services/request_ombd_movies.dart';

class OmdbModelProvider with ChangeNotifier {
  OmdbMovieModel movie = OmdbMovieModel();
  bool loading = false;

  getMovieData(context) async {
    loading = true;
    movie = await getMoviePlot(context);
    loading = false;
    notifyListeners();
  }
}
