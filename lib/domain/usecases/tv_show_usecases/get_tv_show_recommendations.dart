import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class GetTvShowRecommendations {
  final TvShowRepository _repository;

  GetTvShowRecommendations(this._repository);

  Future<Either<Failure, List<TvShow>>> execute(int id) {
    return _repository.getTvShowRecommendations(id);
  }
}
