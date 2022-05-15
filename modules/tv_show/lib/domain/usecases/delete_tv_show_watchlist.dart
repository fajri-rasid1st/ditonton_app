import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_show/tvshow.dart';

class DeleteTvShowWatchlist {
  final TvShowRepository _repository;

  DeleteTvShowWatchlist(this._repository);

  Future<Either<Failure, String>> execute(TvShowDetail tvShow) {
    return _repository.deleteTvShowWatchlist(tvShow);
  }
}
