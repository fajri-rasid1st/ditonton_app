import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetMovieRecommendations {
  final MovieRepository _repository;

  GetMovieRecommendations(this._repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return _repository.getMovieRecommendations(id);
  }
}
