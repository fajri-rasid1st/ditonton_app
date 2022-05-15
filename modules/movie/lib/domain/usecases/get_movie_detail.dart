import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/movie.dart';

class GetMovieDetail {
  final MovieRepository _repository;

  GetMovieDetail(this._repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return _repository.getMovieDetail(id);
  }
}
