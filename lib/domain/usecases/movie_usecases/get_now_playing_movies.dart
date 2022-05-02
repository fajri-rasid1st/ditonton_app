import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetNowPlayingMovies {
  final MovieRepository _repository;

  GetNowPlayingMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getNowPlayingMovies();
  }
}
