import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class GetTvShowEpisodeDetail {
  final TvShowRepository _repository;

  GetTvShowEpisodeDetail(this._repository);

  Future<Either<Failure, Episode>> execute(
    int id,
    int seasonNumber,
    int episodeNumber,
  ) {
    return _repository.getTvShowEpisodeDetail(id, seasonNumber, episodeNumber);
  }
}
