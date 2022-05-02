import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie_entities/movie_detail.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

class DeleteMovieWatchlist {
  final MovieRepository _repository;

  DeleteMovieWatchlist(this._repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return _repository.deleteMovieWatchlist(movie);
  }
}
