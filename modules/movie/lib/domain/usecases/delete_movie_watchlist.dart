import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/movie.dart';

class DeleteMovieWatchlist {
  final MovieRepository _repository;

  DeleteMovieWatchlist(this._repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return _repository.deleteMovieWatchlist(movie);
  }
}
