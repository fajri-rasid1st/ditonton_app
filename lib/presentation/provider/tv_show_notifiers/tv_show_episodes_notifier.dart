import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_tv_show_episodes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TvShowEpisodesNotifier extends ChangeNotifier {
  final GetTvShowEpisodes getTvShowEpisodeDetail;

  TvShowEpisodesNotifier({required this.getTvShowEpisodeDetail});

  List<Episode> _episodes = <Episode>[];
  List<Episode> get episodes => _episodes;

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvShowEpisode(int id, int seasonNumber) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTvShowEpisodeDetail.execute(id, seasonNumber);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (episodes) {
        _episodes = episodes;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
