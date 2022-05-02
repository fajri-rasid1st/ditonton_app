import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

class SearchMovies {
  final MovieRepository _repository;

  SearchMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return _repository.searchMovies(query);
  }
}
