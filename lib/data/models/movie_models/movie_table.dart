import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/entities/movie_entities/movie_detail.dart';

class MovieTable extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String posterPath;

  const MovieTable({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
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
      id: movie['id'],
      title: movie['title'],
      overview: movie['overview'],
      posterPath: movie['posterPath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'posterPath': posterPath,
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
