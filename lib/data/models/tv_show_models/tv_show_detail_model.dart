import 'package:equatable/equatable.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show_detail.dart';
import 'package:ditonton/data/models/genre_model.dart';

class TvShowDetailModel extends Equatable {
  final String? firstAirDate;
  final List<GenreModel> genres;
  final int id;
  final String? lastAirDate;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String? overview;
  final String? posterPath;
  final List<SeasonModel> seasons;
  final double voteAverage;
  final int voteCount;

  const TvShowDetailModel({
    required this.firstAirDate,
    required this.genres,
    required this.id,
    required this.lastAirDate,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.overview,
    required this.posterPath,
    required this.seasons,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvShowDetailModel.fromJson(Map<String, dynamic> detail) {
    return TvShowDetailModel(
      firstAirDate: detail['first_air_date'] ?? '',
      genres: List<GenreModel>.from(
        detail['genres'].map(
          (genre) => GenreModel.fromJson(genre),
        ),
      ),
      id: detail['id'],
      lastAirDate: detail['last_air_date'] ?? '',
      name: detail['name'],
      numberOfEpisodes: detail['number_of_episodes'],
      numberOfSeasons: detail['number_of_seasons'],
      overview: detail['overview'] ?? '',
      posterPath: detail['poster_path'] ?? '',
      seasons: List<SeasonModel>.from(
        detail['seasons'].map(
          (season) => SeasonModel.fromJson(season),
        ),
      ),
      voteAverage: detail['vote_average'].toDouble(),
      voteCount: detail['vote_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_air_date': firstAirDate,
      'genres': List<dynamic>.from(genres.map((genre) => genre.toJson())),
      'id': id,
      'last_air_date': lastAirDate,
      'name': name,
      'number_of_episodes': numberOfEpisodes,
      'number_of_seasons': numberOfSeasons,
      'overview': overview,
      'poster_path': posterPath,
      'seasons': List<dynamic>.from(seasons.map((season) => season.toJson())),
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  TvShowDetail toEntity() {
    return TvShowDetail(
      firstAirDate: firstAirDate ?? '',
      genres: genres.map((genre) => genre.toEntity()).toList(),
      id: id,
      lastAirDate: lastAirDate ?? '',
      name: name,
      numberOfEpisodes: numberOfEpisodes,
      numberOfSeasons: numberOfSeasons,
      overview: overview ?? '',
      posterPath: posterPath ?? '',
      seasons: seasons.map((season) => season.toEntity()).toList(),
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props => [
        firstAirDate,
        genres,
        id,
        lastAirDate,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        overview,
        posterPath,
        seasons,
        voteAverage,
        voteCount,
      ];
}
