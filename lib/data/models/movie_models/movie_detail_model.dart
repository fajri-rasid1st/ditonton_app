import 'package:equatable/equatable.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/movie_entities/movie_detail.dart';

class MovieDetailModel extends Equatable {
  final String? backdropPath;
  final List<GenreModel> genres;
  final int id;
  final String? overview;
  final String? posterPath;
  final String releaseDate;
  final int? runtime;
  final String title;
  final double voteAverage;
  final int voteCount;

  const MovieDetailModel({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.runtime,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> detail) {
    return MovieDetailModel(
      backdropPath: detail['backdrop_path'] ?? '',
      genres: List<GenreModel>.from(
        detail['genres'].map(
          (genre) => GenreModel.fromJson(genre),
        ),
      ),
      id: detail['id'],
      overview: detail['overview'] ?? '',
      posterPath: detail['poster_path'] ?? '',
      releaseDate: detail['release_date'],
      runtime: detail['runtime'] ?? 0,
      title: detail['title'],
      voteAverage: detail['vote_average'].toDouble(),
      voteCount: detail['vote_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'backdrop_path': backdropPath,
      'genres': List<dynamic>.from(genres.map((genre) => genre.toJson())),
      'id': id,
      'overview': overview,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'runtime': runtime,
      'title': title,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  MovieDetail toEntity() {
    return MovieDetail(
      backdropPath: backdropPath ?? '',
      genres: genres.map((genre) => genre.toEntity()).toList(),
      id: id,
      overview: overview ?? '',
      posterPath: posterPath ?? '',
      releaseDate: releaseDate,
      runtime: runtime ?? 0,
      title: title,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        overview,
        posterPath,
        releaseDate,
        runtime,
        title,
        voteAverage,
        voteCount,
      ];
}
