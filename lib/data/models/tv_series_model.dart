import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class TvSeriesModel extends Equatable {
  final int id;
  final String name;
  final String? overview;
  final String? posterPath;

  const TvSeriesModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
  });

  factory TvSeriesModel.fromJson(Map<String, dynamic> tvSeries) {
    return TvSeriesModel(
      id: tvSeries['id'] as int,
      name: tvSeries['name'] as String,
      overview: tvSeries['overview'],
      posterPath: tvSeries['poster_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'overview': overview ?? '',
      'poster_path': posterPath ?? '',
    };
  }

  TvSeries toEntity() {
    return TvSeries(
      id: id,
      name: name,
      overview: overview ?? '',
      posterPath: posterPath ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name, overview, posterPath];
}
