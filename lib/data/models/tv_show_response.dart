import 'package:equatable/equatable.dart';
import 'package:ditonton/data/models/tv_show_model.dart';

class TvShowResponse extends Equatable {
  final List<TvShowModel> tvShows;

  const TvShowResponse({required this.tvShows});

  factory TvShowResponse.fromJson(Map<String, dynamic> tvShows) {
    return TvShowResponse(
      tvShows: List<TvShowModel>.from(
        (tvShows['results'] as List).map(
          (tvShow) => TvShowModel.fromJson(tvShow),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': List<dynamic>.from(tvShows.map((tvShow) => tvShow.toJson())),
    };
  }

  @override
  List<Object> get props => [tvShows];
}
