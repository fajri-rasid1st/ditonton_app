import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_show/domain/repositories/tv_show_repository.dart';

class GetTvShowWatchListStatus {
  final TvShowRepository _repository;

  GetTvShowWatchListStatus(this._repository);

  Future<Either<Failure, bool>> execute(int id) async {
    return _repository.isTvShowAddedToWatchlist(id);
  }
}
