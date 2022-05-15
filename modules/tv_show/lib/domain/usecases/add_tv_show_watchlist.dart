import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_show/tvshow.dart';

class AddTvShowWatchlist {
  final TvShowRepository _repository;

  AddTvShowWatchlist(this._repository);

  Future<Either<Failure, String>> execute(TvShowDetail tvShow) {
    return _repository.addTvShowWatchlist(tvShow);
  }
}
