import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_tv_show_episode_detail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TvShowEpisodeDetailNotifier extends ChangeNotifier {
  final GetTvShowEpisodeDetail getTvShowEpisodeDetail;

  TvShowEpisodeDetailNotifier({required this.getTvShowEpisodeDetail});

  late Episode _episode;
  Episode get episode => _episode;

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvShowEpisode(
    int id,
    int seasonNumber,
    int episodeNumber,
  ) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTvShowEpisodeDetail.execute(
      id,
      seasonNumber,
      episodeNumber,
    );

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (episode) {
        _episode = episode;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
