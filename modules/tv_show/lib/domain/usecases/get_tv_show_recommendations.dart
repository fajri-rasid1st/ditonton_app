import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_show/tvshow.dart';

class GetTvShowRecommendations {
  final TvShowRepository _repository;

  GetTvShowRecommendations(this._repository);

  Future<Either<Failure, List<TvShow>>> execute(int id) {
    return _repository.getTvShowRecommendations(id);
  }
}
