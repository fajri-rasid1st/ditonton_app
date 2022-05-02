import 'package:equatable/equatable.dart';
import 'package:ditonton/data/models/movie_models/movie_model.dart';

class MovieResponse extends Equatable {
  final List<MovieModel> movies;

  const MovieResponse({required this.movies});

  factory MovieResponse.fromJson(Map<String, dynamic> movies) {
    return MovieResponse(
      movies: List<MovieModel>.from(
        (movies['results'] as List).map(
          (movie) => MovieModel.fromJson(movie),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': List<dynamic>.from(movies.map((movies) => movies.toJson())),
    };
  }

  @override
  List<Object> get props => [movies];
}
