import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_show/tvshow.dart';

abstract class TvShowRepository {
  Future<Either<Failure, List<TvShow>>> getOnTheAirTvShows();

  Future<Either<Failure, List<TvShow>>> getPopularTvShows();

  Future<Either<Failure, List<TvShow>>> getTopRatedTvShows();

  Future<Either<Failure, TvShowDetail>> getTvShowDetail(int id);

  Future<Either<Failure, List<TvShow>>> getTvShowRecommendations(int id);

  Future<Either<Failure, List<TvShow>>> searchTvShows(String query);

  Future<Either<Failure, List<Episode>>> getTvShowEpisodes(
    int id,
    int seasonNumber,
  );

  Future<Either<Failure, String>> addTvShowWatchlist(TvShowDetail tvShow);

  Future<Either<Failure, String>> deleteTvShowWatchlist(TvShowDetail tvShow);

  Future<Either<Failure, bool>> isTvShowAddedToWatchlist(int id);

  Future<Either<Failure, List<TvShow>>> getWatchlistTvShows();
}
