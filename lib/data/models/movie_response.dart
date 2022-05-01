import 'package:ditonton/data/models/movie_model.dart';
import 'package:equatable/equatable.dart';

class MovieResponse extends Equatable {
  final List<MovieModel> movieList;

  const MovieResponse({required this.movieList});

  factory MovieResponse.fromJson(Map<String, dynamic> movies) {
    return MovieResponse(
      movieList: List<MovieModel>.from((movies['results'] as List).map((movie) {
        return MovieModel.fromJson(movie);
      })),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': List<dynamic>.from(movieList.map((movies) => movies.toJson())),
    };
  }

  @override
  List<Object> get props => [movieList];
}
