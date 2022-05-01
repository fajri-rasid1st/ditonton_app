import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class MovieDetail extends Equatable {
  final String? backdropPath;
  final List<Genre> genres;
  final String? overview;
  final String? posterPath;
  final String releaseDate;
  final int? runtime;
  final String title;
  final double voteAverage;
  final int voteCount;

  const MovieDetail({
    required this.backdropPath,
    required this.genres,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.runtime,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        overview,
        posterPath,
        releaseDate,
        runtime,
        title,
        voteAverage,
        voteCount,
      ];
}
