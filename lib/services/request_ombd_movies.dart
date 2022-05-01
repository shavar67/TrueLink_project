import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_demo/model/omdb.model.dart';
import '../constants/api_.dart';

Future<OmdbMovieModel> getMoviePlot(id) async {
  OmdbMovieModel movie;
  String url = ApiConstants.OMDBAPIURL +
      id +
      ApiConstants.PLOT +
      ApiConstants.APIKEY.trim();
  Uri uri = Uri.parse(url);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    movie = OmdbMovieModel.fromJson(data);
    return movie;
  } else {
    throw Exception(response.reasonPhrase);
  }
}
