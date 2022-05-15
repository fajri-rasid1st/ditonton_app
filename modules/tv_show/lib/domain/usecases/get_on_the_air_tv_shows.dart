import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_show/tvshow.dart';

class GetOnTheAirTvShows {
  final TvShowRepository _repository;

  GetOnTheAirTvShows(this._repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return _repository.getOnTheAirTvShows();
  }
}
