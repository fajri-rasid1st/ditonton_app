import 'package:equatable/equatable.dart';
import 'package:tv_show/domain/entities/tv_show.dart';

class TvShowModel extends Equatable {
  final int id;
  final String name;
  final String? overview;
  final String? posterPath;

  const TvShowModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
  });

  factory TvShowModel.fromJson(Map<String, dynamic> tvShow) {
    return TvShowModel(
      id: tvShow['id'] as int,
      name: tvShow['name'] as String,
      overview: tvShow['overview'] ?? '',
      posterPath: tvShow['poster_path'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'poster_path': posterPath,
    };
  }

  TvShow toEntity() {
    return TvShow(
      id: id,
      name: name,
      overview: overview ?? '',
      posterPath: posterPath ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name, overview, posterPath];
}
