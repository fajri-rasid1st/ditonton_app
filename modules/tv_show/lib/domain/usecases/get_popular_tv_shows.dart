import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_show/tvshow.dart';

class GetPopularTvShows {
  final TvShowRepository _repository;

  GetPopularTvShows(this._repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return _repository.getPopularTvShows();
  }
}
