import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/movie.dart';

class GetPopularMovies {
  final MovieRepository _repository;

  GetPopularMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getPopularMovies();
  }
}
