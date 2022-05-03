import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_popular_tv_shows.dart';
import 'package:flutter/foundation.dart';

class PopularTvShowsNotifier extends ChangeNotifier {
  final GetPopularTvShows getPopularTvShows;

  PopularTvShowsNotifier({required this.getPopularTvShows});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<TvShow> _tvShows = [];
  List<TvShow> get tvShows => _tvShows;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTvShows() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getPopularTvShows.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (tvShowsData) {
        _tvShows = tvShowsData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
