import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/movie_usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_on_the_air_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_popular_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_top_rated_tv_shows.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/movie_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([
  GetOnTheAirTvShows,
  GetPopularTvShows,
  GetTopRatedTvShows,
])
void main() {
  // late MovieListNotifier provider;
  // late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  // late MockGetPopularMovies mockGetPopularMovies;
  // late MockGetTopRatedMovies mockGetTopRatedMovies;
  // late int listenerCallCount;

  // setUp(() {
  //   listenerCallCount = 0;

  //   mockGetNowPlayingMovies = MockGetNowPlayingMovies();
  //   mockGetPopularMovies = MockGetPopularMovies();
  //   mockGetTopRatedMovies = MockGetTopRatedMovies();

  //   provider = MovieListNotifier(
  //     getNowPlayingMovies: mockGetNowPlayingMovies,
  //     getPopularMovies: mockGetPopularMovies,
  //     getTopRatedMovies: mockGetTopRatedMovies,
  //   )..addListener(() => listenerCallCount++);
  // });

  // const tMovie = Movie(
  //   id: 1,
  //   title: 'title',
  //   overview: 'overview',
  //   posterPath: 'posterPath',
  // );

  // final tMovieList = <Movie>[tMovie];

  // group('Now playing movies', () {
  //   test('InitialState should be Empty', () {
  //     expect(provider.nowPlayingMovieState, equals(RequestState.empty));
  //   });

  //   test('Should get data from the usecase', () async {
  //     // arrange
  //     when(mockGetNowPlayingMovies.execute())
  //         .thenAnswer((_) async => Right(tMovieList));

  //     // act
  //     provider.fetchNowPlayingMovies();

  //     // assert
  //     verify(mockGetNowPlayingMovies.execute());
  //   });

  //   test('Should change state to Loading when usecase is called', () {
  //     // arrange
  //     when(mockGetNowPlayingMovies.execute())
  //         .thenAnswer((_) async => Right(tMovieList));

  //     // act
  //     provider.fetchNowPlayingMovies();

  //     // assert
  //     expect(provider.nowPlayingMovieState, RequestState.loading);
  //   });

  //   test('Should change movies when data is gotten successfully', () async {
  //     // arrange
  //     when(mockGetNowPlayingMovies.execute())
  //         .thenAnswer((_) async => Right(tMovieList));

  //     // act
  //     await provider.fetchNowPlayingMovies();

  //     // assert
  //     expect(provider.nowPlayingMovieState, RequestState.loaded);
  //     expect(provider.nowPlayingMovies, tMovieList);
  //     expect(listenerCallCount, 2);
  //   });

  //   test('Should return error when data is unsuccessful', () async {
  //     // arrange
  //     when(mockGetNowPlayingMovies.execute())
  //         .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

  //     // act
  //     await provider.fetchNowPlayingMovies();

  //     // assert
  //     expect(provider.nowPlayingMovieState, RequestState.error);
  //     expect(provider.message, 'Server Failure');
  //     expect(listenerCallCount, 2);
  //   });
  // });

  // group('Popular movies', () {
  //   test('Should change state to loading when usecase is called', () async {
  //     // arrange
  //     when(mockGetPopularMovies.execute())
  //         .thenAnswer((_) async => Right(tMovieList));

  //     // act
  //     provider.fetchPopularMovies();

  //     // assert
  //     expect(provider.popularMoviesState, RequestState.loading);
  //   });

  //   test(
  //     'Should change movies data when data is gotten successfully',
  //     () async {
  //       // arrange
  //       when(mockGetPopularMovies.execute())
  //           .thenAnswer((_) async => Right(tMovieList));

  //       // act
  //       await provider.fetchPopularMovies();

  //       // assert
  //       expect(provider.popularMoviesState, RequestState.loaded);
  //       expect(provider.popularMovies, tMovieList);
  //       expect(listenerCallCount, 2);
  //     },
  //   );

  //   test('Should return error when data is unsuccessful', () async {
  //     // arrange
  //     when(mockGetPopularMovies.execute())
  //         .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

  //     // act
  //     await provider.fetchPopularMovies();

  //     // assert
  //     expect(provider.popularMoviesState, RequestState.error);
  //     expect(provider.message, 'Server Failure');
  //     expect(listenerCallCount, 2);
  //   });
  // });

  // group('Top rated movies', () {
  //   test('Should change state to loading when usecase is called', () async {
  //     // arrange
  //     when(mockGetTopRatedMovies.execute())
  //         .thenAnswer((_) async => Right(tMovieList));

  //     // act
  //     provider.fetchTopRatedMovies();

  //     // assert
  //     expect(provider.topRatedMoviesState, RequestState.loading);
  //   });

  //   test(
  //     'Should change movies data when data is gotten successfully',
  //     () async {
  //       // arrange
  //       when(mockGetTopRatedMovies.execute())
  //           .thenAnswer((_) async => Right(tMovieList));

  //       // act
  //       await provider.fetchTopRatedMovies();

  //       // assert
  //       expect(provider.topRatedMoviesState, RequestState.loaded);
  //       expect(provider.topRatedMovies, tMovieList);
  //       expect(listenerCallCount, 2);
  //     },
  //   );

  //   test('Should return error when data is unsuccessful', () async {
  //     // arrange
  //     when(mockGetTopRatedMovies.execute())
  //         .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

  //     // act
  //     await provider.fetchTopRatedMovies();

  //     // assert
  //     expect(provider.topRatedMoviesState, RequestState.error);
  //     expect(provider.message, 'Server Failure');
  //     expect(listenerCallCount, 2);
  //   });
  // });
}
