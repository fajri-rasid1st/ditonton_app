import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/search_tv_shows.dart';
import 'package:flutter/foundation.dart';

class TvShowSearchNotifier extends ChangeNotifier {
  final SearchTvShows searchTvShows;

  TvShowSearchNotifier({required this.searchTvShows});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<TvShow> _searchResult = <TvShow>[];
  List<TvShow> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvShowSearch(String query) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await searchTvShows.execute(query);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
