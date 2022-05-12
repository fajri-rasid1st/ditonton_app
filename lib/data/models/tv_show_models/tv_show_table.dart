import 'package:ditonton/data/models/tv_show_models/tv_show_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show_detail.dart';

class TvShowTable extends Equatable {
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final DateTime? createdAt;

  const TvShowTable({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    this.createdAt,
  });

  factory TvShowTable.fromEntity(TvShowDetail tvShow) {
    return TvShowTable(
      id: tvShow.id,
      name: tvShow.name,
      overview: tvShow.overview,
      posterPath: tvShow.posterPath,
    );
  }

  factory TvShowTable.fromMap(Map<String, dynamic> tvShow) {
    return TvShowTable(
      id: tvShow[TvShowWatchlistFields.id],
      name: tvShow[TvShowWatchlistFields.name],
      overview: tvShow[TvShowWatchlistFields.overview],
      posterPath: tvShow[TvShowWatchlistFields.posterPath],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      TvShowWatchlistFields.id: id,
      TvShowWatchlistFields.name: name,
      TvShowWatchlistFields.overview: overview,
      TvShowWatchlistFields.posterPath: posterPath,
      TvShowWatchlistFields.createdAt:
          createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
    };
  }

  TvShow toEntity() {
    return TvShow.watchlist(
      id: id,
      name: name,
      overview: overview,
      posterPath: posterPath,
    );
  }

  @override
  List<Object?> get props => [id, name, overview, posterPath];
}
