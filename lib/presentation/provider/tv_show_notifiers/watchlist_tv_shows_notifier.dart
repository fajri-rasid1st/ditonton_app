import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_watchlist_tv_shows.dart';
import 'package:flutter/foundation.dart';

class WatchlistTvShowsNotifier extends ChangeNotifier {
  final GetWatchlistTvShows getWatchlistTvShows;

  WatchlistTvShowsNotifier({required this.getWatchlistTvShows});

  List<TvShow> _watchlistTvShows = <TvShow>[];
  List<TvShow> get watchlistTvShows => _watchlistTvShows;

  RequestState _watchlistState = RequestState.empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  Future<void> fetchWatchlistTvShows() async {
    _watchlistState = RequestState.loading;
    notifyListeners();

    final result = await getWatchlistTvShows.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _watchlistState = RequestState.error;
        notifyListeners();
      },
      (tvShowsData) {
        _watchlistTvShows = tvShowsData;
        _watchlistState = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
