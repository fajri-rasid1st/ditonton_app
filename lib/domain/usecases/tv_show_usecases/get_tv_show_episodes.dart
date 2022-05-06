import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class GetTvShowEpisodes {
  final TvShowRepository _repository;

  GetTvShowEpisodes(this._repository);

  Future<Either<Failure, List<Episode>>> execute(int id, int seasonNumber) {
    return _repository.getTvShowEpisodes(id, seasonNumber);
  }
}
