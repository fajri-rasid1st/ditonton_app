import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie_entities/movie_detail.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

class GetMovieDetail {
  final MovieRepository _repository;

  GetMovieDetail(this._repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return _repository.getMovieDetail(id);
  }
}
