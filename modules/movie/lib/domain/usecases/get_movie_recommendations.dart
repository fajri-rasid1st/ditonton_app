import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/movie.dart';

class GetMovieRecommendations {
  final MovieRepository _repository;

  GetMovieRecommendations(this._repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return _repository.getMovieRecommendations(id);
  }
}
