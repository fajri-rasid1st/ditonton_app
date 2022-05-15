import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/movie.dart';

class GetNowPlayingMovies {
  final MovieRepository _repository;

  GetNowPlayingMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getNowPlayingMovies();
  }
}
