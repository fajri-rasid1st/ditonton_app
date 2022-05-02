import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

class GetMovieWatchListStatus {
  final MovieRepository _repository;

  GetMovieWatchListStatus(this._repository);

  Future<Either<Failure, bool>> execute(int id) async {
    return _repository.isMovieAddedToWatchlist(id);
  }
}
