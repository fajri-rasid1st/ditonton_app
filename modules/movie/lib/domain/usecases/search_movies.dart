import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/movie.dart';

class SearchMovies {
  final MovieRepository _repository;

  SearchMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return _repository.searchMovies(query);
  }
}
