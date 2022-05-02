import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show_detail.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class AddTvShowWatchlist {
  final TvShowRepository _repository;

  AddTvShowWatchlist(this._repository);

  Future<Either<Failure, String>> execute(TvShowDetail tvShow) {
    return _repository.addTvShowWatchlist(tvShow);
  }
}
