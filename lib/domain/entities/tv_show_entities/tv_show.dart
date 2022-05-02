import 'package:equatable/equatable.dart';

class TvShow extends Equatable {
  final int id;
  final String name;
  final String overview;
  final String posterPath;

  const TvShow({
    required this.id,
    required this.posterPath,
    required this.name,
    required this.overview,
  });

  const TvShow.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name, overview, posterPath];
}
