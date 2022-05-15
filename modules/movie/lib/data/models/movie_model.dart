import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';

class MovieModel extends Equatable {
  final int id;
  final String title;
  final String? overview;
  final String? posterPath;

  const MovieModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
  });

  factory MovieModel.fromJson(Map<String, dynamic> movie) {
    return MovieModel(
      id: movie['id'] as int,
      title: movie['title'] as String,
      overview: movie['overview'] ?? '',
      posterPath: movie['poster_path'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
    };
  }

  Movie toEntity() {
    return Movie(
      id: id,
      title: title,
      overview: overview ?? '',
      posterPath: posterPath ?? '',
    );
  }

  @override
  List<Object?> get props => [id, title, overview, posterPath];
}
