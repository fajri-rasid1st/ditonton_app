import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_on_the_air_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_popular_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_top_rated_tv_shows.dart';
import 'package:flutter/material.dart';

class TvShowListNotifier extends ChangeNotifier {
  final GetOnTheAirTvShows getOnTheAirTvShows;
  final GetPopularTvShows getPopularTvShows;
  final GetTopRatedTvShows getTopRatedTvShows;

  TvShowListNotifier({
    required this.getOnTheAirTvShows,
    required this.getPopularTvShows,
    required this.getTopRatedTvShows,
  });

  List<TvShow> _onTheAirTvShows = <TvShow>[];
  List<TvShow> get onTheAirTvShows => _onTheAirTvShows;

  RequestState _onTheAirTvShowsState = RequestState.empty;
  RequestState get onTheAirTvShowsState => _onTheAirTvShowsState;

  List<TvShow> _popularTvShows = <TvShow>[];
  List<TvShow> get popularTvShows => _popularTvShows;

  RequestState _popularTvShowsState = RequestState.empty;
  RequestState get popularTvShowsState => _popularTvShowsState;

  List<TvShow> _topRatedTvShows = <TvShow>[];
  List<TvShow> get topRatedTvShows => _topRatedTvShows;

  RequestState _topRatedTvShowsState = RequestState.empty;
  RequestState get topRatedTvShowsState => _topRatedTvShowsState;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnTheAirTvShows() async {
    _onTheAirTvShowsState = RequestState.loading;
    notifyListeners();

    final result = await getOnTheAirTvShows.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _onTheAirTvShowsState = RequestState.error;
        notifyListeners();
      },
      (tvShowsData) {
        _onTheAirTvShows = tvShowsData;
        _onTheAirTvShowsState = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvShows() async {
    _popularTvShowsState = RequestState.loading;
    notifyListeners();

    final result = await getPopularTvShows.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _popularTvShowsState = RequestState.error;
        notifyListeners();
      },
      (tvShowsData) {
        _popularTvShows = tvShowsData;
        _popularTvShowsState = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvShows() async {
    _topRatedTvShowsState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTvShows.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _topRatedTvShowsState = RequestState.error;
        notifyListeners();
      },
      (tvShowsData) {
        _topRatedTvShows = tvShowsData;
        _topRatedTvShowsState = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
