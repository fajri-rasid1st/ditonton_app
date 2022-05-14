import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/search_tv_shows.dart';
import 'package:ditonton/presentation/bloc/tv_show_search_bloc/tv_show_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_show_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTvShows])
void main() {
  late TvShowSearchBloc searchBloc;
  late MockSearchTvShows mockSearchTvShows;

  const tQuery = 'game';

  setUp(() {
    mockSearchTvShows = MockSearchTvShows();
    searchBloc = TvShowSearchBloc(searchTvShows: mockSearchTvShows);
  });

  test('Initial state should be empty', () {
    expect(searchBloc.state, TvShowSearchEmpty());
  });

  blocTest<TvShowSearchBloc, TvShowSearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => const Right(testTvShowList));

      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnTvShowQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvShowSearchLoading(),
      const TvShowSearchHasData(testTvShowList),
    ],
    verify: (bloc) => verify(mockSearchTvShows.execute(tQuery)),
  );

  blocTest<TvShowSearchBloc, TvShowSearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnTvShowQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvShowSearchLoading(),
      const TvShowSearchError('Server Failure'),
    ],
    verify: (bloc) => verify(mockSearchTvShows.execute(tQuery)),
  );
}
