import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/movie.dart';

class GetTopRatedMovies {
  final MovieRepository _repository;

  GetTopRatedMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getTopRatedMovies();
  }
}
