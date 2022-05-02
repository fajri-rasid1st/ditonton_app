import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show_detail.dart';

class TvShowTable extends Equatable {
  final int id;
  final String name;
  final String overview;
  final String posterPath;

  const TvShowTable({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
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
      id: tvShow['id'],
      name: tvShow['name'],
      overview: tvShow['overview'],
      posterPath: tvShow['posterPath'],
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
