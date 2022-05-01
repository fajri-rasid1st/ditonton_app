import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

class TvTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  const TvTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory TvTable.fromEntity(MovieDetail movie) {
    return MovieTable(
      id: movie.id,
      title: movie.title,
      posterPath: movie.posterPath,
      overview: movie.overview,
    );
  }

  factory MovieTable.fromMap(Map<String, dynamic> map) {
    return MovieTable(
      id: map['id'],
      title: map['title'],
      posterPath: map['posterPath'],
      overview: map['overview'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'posterPath': posterPath,
      'overview': overview,
    };
  }

  Movie toEntity() {
    return Movie.watchlist(
      id: id,
      overview: overview,
      posterPath: posterPath,
      title: title,
    );
  }

  @override
  List<Object?> get props => [id, title, posterPath, overview];
}
