import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_tv_show_episodes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_show_episodes_event.dart';
part 'tv_show_episodes_state.dart';

class TvShowEpisodesBloc
    extends Bloc<TvShowEpisodesEvent, TvShowEpisodesState> {
  final GetTvShowEpisodes getTvShowEpisodes;

  TvShowEpisodesBloc({required this.getTvShowEpisodes})
      : super(TvShowEpisodesEmpty()) {
    on<FetchTvShowEpisodes>((event, emit) async {
      emit(TvShowEpisodesLoading());

      final id = event.id;
      final seasonNumber = event.seasonNumber;

      final result = await getTvShowEpisodes.execute(id, seasonNumber);

      result.fold(
        (failure) => emit(TvShowEpisodesError(failure.message)),
        (episodes) => emit(TvShowEpisodesHasData(episodes)),
      );
    });
  }
}
