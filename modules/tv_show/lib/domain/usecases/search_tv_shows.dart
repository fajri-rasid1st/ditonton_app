import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_show/tvshow.dart';

class SearchTvShows {
  final TvShowRepository _repository;

  SearchTvShows(this._repository);

  Future<Either<Failure, List<TvShow>>> execute(String query) {
    return _repository.searchTvShows(query);
  }
}
