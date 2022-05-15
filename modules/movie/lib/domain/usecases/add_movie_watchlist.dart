import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/movie.dart';

class AddMovieWatchlist {
  final MovieRepository _repository;

  AddMovieWatchlist(this._repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return _repository.addMovieWatchlist(movie);
  }
}
