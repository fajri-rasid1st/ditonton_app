import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie_entities/movie.dart';
import 'package:ditonton/domain/usecases/movie_usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/search_tv_shows.dart';
import 'package:ditonton/presentation/provider/movie_notifiers/movie_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([SearchTvShows])
void main() {
  // late MovieSearchNotifier provider;
  // late MockSearchMovies mockSearchMovies;
  // late int listenerCallCount;

  // setUp(() {
  //   listenerCallCount = 0;

  //   mockSearchMovies = MockSearchMovies();

  //   provider = MovieSearchNotifier(searchMovies: mockSearchMovies)
  //     ..addListener(() => listenerCallCount++);
  // });

  // const tQuery = 'Spiderman';

  // const tMovieModel = Movie(
  //   id: 557,
  //   title: 'Spider-Man',
  //   overview:
  //       'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  //   posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  // );

  // final tMovieList = <Movie>[tMovieModel];

  // group('Search movies', () {
  //   test('Should change state to loading when usecase is called', () async {
  //     // arrange
  //     when(mockSearchMovies.execute(tQuery))
  //         .thenAnswer((_) async => Right(tMovieList));

  //     // act
  //     provider.fetchMovieSearch(tQuery);

  //     // assert
  //     expect(provider.state, RequestState.loading);
  //   });

  //   test(
  //     'Should change search result data when data is gotten successfully',
  //     () async {
  //       // arrange
  //       when(mockSearchMovies.execute(tQuery))
  //           .thenAnswer((_) async => Right(tMovieList));

  //       // act
  //       await provider.fetchMovieSearch(tQuery);

  //       // assert
  //       expect(provider.state, RequestState.loaded);
  //       expect(provider.searchResult, tMovieList);
  //       expect(listenerCallCount, 2);
  //     },
  //   );

  //   test('Should return error when data is unsuccessful', () async {
  //     // arrange
  //     when(mockSearchMovies.execute(tQuery))
  //         .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

  //     // act
  //     await provider.fetchMovieSearch(tQuery);

  //     // assert
  //     expect(provider.state, RequestState.error);
  //     expect(provider.message, 'Server Failure');
  //     expect(listenerCallCount, 2);
  //   });
  // });
}
