import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesTable extends Equatable {
  final int id;
  final String name;
  final String overview;
  final String posterPath;

  const TvSeriesTable({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
  });

  factory TvSeriesTable.fromEntity(TvSeriesDetail tvSeries) {
    return TvSeriesTable(
      id: tvSeries.id,
      name: tvSeries.name,
      overview: tvSeries.overview,
      posterPath: tvSeries.posterPath,
    );
  }

  factory TvSeriesTable.fromMap(Map<String, dynamic> tvSeries) {
    return TvSeriesTable(
      id: tvSeries['id'],
      name: tvSeries['name'],
      overview: tvSeries['overview'],
      posterPath: tvSeries['posterPath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'posterPath': posterPath,
    };
  }

  TvSeries toEntity() {
    return TvSeries.watchlist(
      id: id,
      name: name,
      overview: overview,
      posterPath: posterPath,
    );
  }

  @override
  List<Object?> get props => [id, name, overview, posterPath];
}
