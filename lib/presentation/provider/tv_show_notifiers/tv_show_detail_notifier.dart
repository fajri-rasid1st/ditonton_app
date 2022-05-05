import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show_detail.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/add_tv_show_watchlist.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/delete_tv_show_watchlist.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_tv_show_detail.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_tv_show_recommendations.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_tv_show_watchlist_status.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TvShowDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added Tv Show to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed Tv Show from Watchlist';

  final GetTvShowDetail getTvShowDetail;
  final GetTvShowRecommendations getTvShowRecommendations;
  final GetTvShowWatchListStatus getTvShowWatchListStatus;
  final AddTvShowWatchlist addTvShowWatchlist;
  final DeleteTvShowWatchlist deleteTvShowWatchlist;

  TvShowDetailNotifier({
    required this.getTvShowDetail,
    required this.getTvShowRecommendations,
    required this.getTvShowWatchListStatus,
    required this.addTvShowWatchlist,
    required this.deleteTvShowWatchlist,
  });

  late TvShowDetail _tvShow;
  TvShowDetail get tvShow => _tvShow;

  RequestState _tvShowState = RequestState.empty;
  RequestState get tvShowState => _tvShowState;

  List<TvShow> _tvShowRecommendations = <TvShow>[];
  List<TvShow> get tvShowRecommendations => _tvShowRecommendations;

  RequestState _recommendationState = RequestState.empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> fetchTvShowDetail(int id) async {
    _tvShowState = RequestState.loading;
    notifyListeners();

    final detailResult = await getTvShowDetail.execute(id);
    final recommendationResult = await getTvShowRecommendations.execute(id);

    detailResult.fold(
      (failure) {
        _message = failure.message;
        _tvShowState = RequestState.error;
        notifyListeners();
      },
      (tvShow) {
        _tvShow = tvShow;
        _recommendationState = RequestState.loading;
        notifyListeners();

        recommendationResult.fold(
          (failure) {
            _message = failure.message;
            _recommendationState = RequestState.error;
          },
          (tvShows) {
            _tvShowRecommendations = tvShows;
            _recommendationState = RequestState.loaded;
          },
        );

        _tvShowState = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  Future<void> addTvShowToWatchlist(TvShowDetail tvShow) async {
    final result = await addTvShowWatchlist.execute(tvShow);

    await result.fold(
      (failure) async => _watchlistMessage = failure.message,
      (successMessage) async => _watchlistMessage = successMessage,
    );

    await loadTvShowWatchlistStatus(tvShow.id);
  }

  Future<void> removeTvShowFromWatchlist(TvShowDetail tvShow) async {
    final result = await deleteTvShowWatchlist.execute(tvShow);

    await result.fold(
      (failure) async => _watchlistMessage = failure.message,
      (successMessage) async => _watchlistMessage = successMessage,
    );

    await loadTvShowWatchlistStatus(tvShow.id);
  }

  Future<void> loadTvShowWatchlistStatus(int id) async {
    final result = await getTvShowWatchListStatus.execute(id);

    await result.fold(
      (failure) async => _watchlistMessage = failure.message,
      (isAdded) async => _isAddedtoWatchlist = isAdded,
    );

    notifyListeners();
  }
}
