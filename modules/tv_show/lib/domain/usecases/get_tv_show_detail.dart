import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_show/tvshow.dart';

class GetTvShowDetail {
  final TvShowRepository _repository;

  GetTvShowDetail(this._repository);

  Future<Either<Failure, TvShowDetail>> execute(int id) {
    return _repository.getTvShowDetail(id);
  }
}
