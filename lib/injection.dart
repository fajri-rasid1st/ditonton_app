import 'package:core/utils/http_ssl_pinning.dart';
import 'package:database/data/datasources/db/database_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/movie.dart';
import 'package:tv_show/tvshow.dart';

final locator = GetIt.instance;

void init() {
  // Movie blocs
  locator.registerFactory(
    () => MovieWatchlistBloc(
      getMovieWatchListStatus: locator(),
      addMovieWatchlist: locator(),
      deleteMovieWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
    ),
  );
  locator.registerFactory(
    () => MovielistBloc(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchBloc(searchMovies: locator()),
  );
  locator.registerFactory(
    () => NowPlayingMoviesBloc(getNowPlayingMovies: locator()),
  );
  locator.registerFactory(
    () => PopularMoviesBloc(getPopularMovies: locator()),
  );
  locator.registerFactory(
    () => TopRatedMoviesBloc(getTopRatedMovies: locator()),
  );
  locator.registerFactory(
    () => WatchlistMoviesBloc(getWatchlistMovies: locator()),
  );

  // Tv show blocs
  locator.registerFactory(
    () => TvShowWatchlistBloc(
      getTvShowWatchListStatus: locator(),
      addTvShowWatchlist: locator(),
      deleteTvShowWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowDetailBloc(
      getTvShowDetail: locator(),
      getTvShowRecommendations: locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowlistBloc(
      getOnTheAirTvShows: locator(),
      getPopularTvShows: locator(),
      getTopRatedTvShows: locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowSearchBloc(searchTvShows: locator()),
  );
  locator.registerFactory(
    () => OnTheAirTvShowsBloc(getOnTheAirTvShows: locator()),
  );
  locator.registerFactory(
    () => PopularTvShowsBloc(getPopularTvShows: locator()),
  );
  locator.registerFactory(
    () => TopRatedTvShowsBloc(getTopRatedTvShows: locator()),
  );
  locator.registerFactory(
    () => TvShowEpisodesBloc(getTvShowEpisodes: locator()),
  );
  locator.registerFactory(
    () => WatchlistTvShowsBloc(getWatchlistTvShows: locator()),
  );

  // Movie use cases
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetMovieWatchListStatus(locator()));
  locator.registerLazySingleton(() => AddMovieWatchlist(locator()));
  locator.registerLazySingleton(() => DeleteMovieWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // Tv show use cases
  locator.registerLazySingleton(() => GetOnTheAirTvShows(locator()));
  locator.registerLazySingleton(() => GetPopularTvShows(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvShows(locator()));
  locator.registerLazySingleton(() => GetTvShowDetail(locator()));
  locator.registerLazySingleton(() => GetTvShowRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvShows(locator()));
  locator.registerLazySingleton(() => GetTvShowWatchListStatus(locator()));
  locator.registerLazySingleton(() => AddTvShowWatchlist(locator()));
  locator.registerLazySingleton(() => DeleteTvShowWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvShows(locator()));
  locator.registerLazySingleton(() => GetTvShowEpisodes(locator()));

  // Repositories
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvShowRepository>(
    () => TvShowRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // Movie data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // Tv show data sources
  locator.registerLazySingleton<TvShowRemoteDataSource>(
      () => TvShowRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvShowLocalDataSource>(
      () => TvShowLocalDataSourceImpl(databaseHelper: locator()));

  // Helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // External
  locator.registerLazySingleton(() => HttpSslPinning.client);
}
