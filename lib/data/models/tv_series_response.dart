import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:equatable/equatable.dart';

class TvSeriesResponse extends Equatable {
  final List<TvSeriesModel> tvSeriesList;

  const TvSeriesResponse({required this.tvSeriesList});

  factory TvSeriesResponse.fromJson(Map<String, dynamic> tvSeries) {
    return TvSeriesResponse(
      tvSeriesList:
          List<TvSeriesModel>.from((tvSeries['results'] as List).map((movie) {
        return TvSeriesModel.fromJson(movie);
      })),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results':
          List<dynamic>.from(tvSeriesList.map((movies) => movies.toJson())),
    };
  }

  @override
  List<Object> get props => [tvSeriesList];
}
