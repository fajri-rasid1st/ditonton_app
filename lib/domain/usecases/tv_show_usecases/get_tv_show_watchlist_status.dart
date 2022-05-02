import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class GetTvShowWatchListStatus {
  final TvShowRepository _repository;

  GetTvShowWatchListStatus(this._repository);

  Future<Either<Failure, bool>> execute(int id) async {
    return _repository.isTvShowAddedToWatchlist(id);
  }
}
