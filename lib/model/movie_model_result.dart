import 'package:movie_demo/model/movie_model.dart';
import 'package:provider/provider.dart';

class MovieModelResult {
  late List<MovieModel> result;
  String? totalResults;
  String? response;

  MovieModelResult({required this.result, this.totalResults, this.response});

  MovieModelResult.fromJson(Map<String, dynamic> json) {
    if (json['Search'] != null) {
      result = <MovieModel>[];
      json['Search'].forEach((v) {
        result.add(MovieModel.fromJson(v));
      });
    }
    totalResults = json['totalResults'];
    response = json['Response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['Search'] = this.result.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
