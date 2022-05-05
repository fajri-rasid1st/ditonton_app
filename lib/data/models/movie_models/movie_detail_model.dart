import 'package:equatable/equatable.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/movie_entities/movie_detail.dart';

class MovieDetailModel extends Equatable {
  final List<GenreModel> genres;
  final int id;
  final String? overview;
  final String? posterPath;
  final int? runtime;
  final String title;
  final double voteAverage;
  final int voteCount;

  const MovieDetailModel({
    required this.genres,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.runtime,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> detail) {
    return MovieDetailModel(
      genres: List<GenreModel>.from(
        detail['genres'].map(
          (genre) => GenreModel.fromJson(genre),
        ),
      ),
      id: detail['id'],
      overview: detail['overview'] ?? '',
      posterPath: detail['poster_path'] ?? '',
      runtime: detail['runtime'] ?? 0,
      title: detail['title'],
      voteAverage: detail['vote_average'].toDouble(),
      voteCount: detail['vote_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'genres': List<dynamic>.from(genres.map((genre) => genre.toJson())),
      'id': id,
      'overview': overview,
      'poster_path': posterPath,
      'runtime': runtime,
      'title': title,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  MovieDetail toEntity() {
    return MovieDetail(
      genres: genres.map((genre) => genre.toEntity()).toList(),
      id: id,
      overview: overview ?? '',
      posterPath: posterPath ?? '',
      runtime: runtime ?? 0,
      title: title,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props => [
        genres,
        id,
        overview,
        posterPath,
        runtime,
        title,
        voteAverage,
        voteCount,
      ];
}
