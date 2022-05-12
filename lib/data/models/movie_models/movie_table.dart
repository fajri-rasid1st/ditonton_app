import 'package:ditonton/data/models/movie_models/movie_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/entities/movie_entities/movie_detail.dart';

class MovieTable extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final DateTime? createdAt;

  const MovieTable({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    this.createdAt,
  });

  factory MovieTable.fromEntity(MovieDetail movie) {
    return MovieTable(
      id: movie.id,
      title: movie.title,
      overview: movie.overview,
      posterPath: movie.posterPath,
    );
  }

  factory MovieTable.fromMap(Map<String, dynamic> movie) {
    return MovieTable(
      id: movie[MovieWatchlistFields.id],
      title: movie[MovieWatchlistFields.title],
      overview: movie[MovieWatchlistFields.overview],
      posterPath: movie[MovieWatchlistFields.posterPath],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      MovieWatchlistFields.id: id,
      MovieWatchlistFields.title: title,
      MovieWatchlistFields.overview: overview,
      MovieWatchlistFields.posterPath: posterPath,
      MovieWatchlistFields.createdAt:
          createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
    };
  }

  Movie toEntity() {
    return Movie.watchlist(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath,
    );
  }

  @override
  List<Object?> get props => [id, title, overview, posterPath];
}
