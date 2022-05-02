import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

class GetPopularMovies {
  final MovieRepository _repository;

  GetPopularMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getPopularMovies();
  }
}
