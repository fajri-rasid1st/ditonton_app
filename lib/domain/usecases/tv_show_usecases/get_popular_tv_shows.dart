import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class GetPopularTvShows {
  final TvShowRepository _repository;

  GetPopularTvShows(this._repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return _repository.getPopularTvShows();
  }
}