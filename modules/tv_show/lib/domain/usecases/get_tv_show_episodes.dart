import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_show/tvshow.dart';

class GetTvShowEpisodes {
  final TvShowRepository _repository;

  GetTvShowEpisodes(this._repository);

  Future<Either<Failure, List<Episode>>> execute(int id, int seasonNumber) {
    return _repository.getTvShowEpisodes(id, seasonNumber);
  }
}
