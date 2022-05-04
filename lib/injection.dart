import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_show_datasources/tv_show_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_show_datasources/tv_show_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_show_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';
import 'package:ditonton/domain/usecases/movie_usecases/add_movie_watchlist.dart';
import 'package:ditonton/domain/usecases/movie_usecases/delete_movie_watchlist.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_movie_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie_usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/add_tv_show_watchlist.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/delete_tv_show_watchlist.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_on_the_air_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_popular_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_top_rated_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_tv_show_detail.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_tv_show_episode_detail.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_tv_show_recommendations.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_tv_show_watchlist_status.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_watchlist_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/search_tv_shows.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/watchlist_movies_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/on_the_air_tv_shows_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/popular_tv_shows_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/top_rated_tv_shows_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/tv_show_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/tv_show_episode_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/tv_show_list_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/tv_show_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/watchlist_tv_shows_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // Movie providers
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getMovieWatchListStatus: locator(),
      addMovieWatchlist: locator(),
      deleteMovieWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(searchMovies: locator()),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(getPopularMovies: locator()),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(getTopRatedMovies: locator()),
  );
  locator.registerFactory(
    () => WatchlistMoviesNotifier(getWatchlistMovies: locator()),
  );

  // Tv show providers
  locator.registerFactory(
    () => TvShowListNotifier(
      getOnTheAirTvShows: locator(),
      getPopularTvShows: locator(),
      getTopRatedTvShows: locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowDetailNotifier(
      getTvShowDetail: locator(),
      getTvShowRecommendations: locator(),
      getTvShowWatchListStatus: locator(),
      addTvShowWatchlist: locator(),
      deleteTvShowWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowEpisodeDetailNotifier(getTvShowEpisodeDetail: locator()),
  );
  locator.registerFactory(
    () => TvShowSearchNotifier(searchTvShows: locator()),
  );
  locator.registerFactory(
    () => OnTheAirTvShowsNotifier(getOnTheAirTvShows: locator()),
  );
  locator.registerFactory(
    () => PopularTvShowsNotifier(getPopularTvShows: locator()),
  );
  locator.registerFactory(
    () => TopRatedTvShowsNotifier(getTopRatedTvShows: locator()),
  );
  locator.registerFactory(
    () => WatchlistTvShowsNotifier(getWatchlistTvShows: locator()),
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
  locator.registerLazySingleton(() => GetTvShowEpisodeDetail(locator()));

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
  locator.registerLazySingleton(() => http.Client());
}
