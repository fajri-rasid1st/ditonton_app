import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/search_tv_shows.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/tv_show_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_show_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvShows])
void main() {
  late TvShowSearchNotifier provider;
  late MockSearchTvShows mockSearchTvShows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;

    mockSearchTvShows = MockSearchTvShows();

    provider = TvShowSearchNotifier(searchTvShows: mockSearchTvShows)
      ..addListener(() => listenerCallCount++);
  });

  const tQuery = 'Game';

  const tTvShowModel = TvShow(
    id: 1399,
    name: "Game of Thrones",
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    posterPath: '/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg',
  );

  final tTvShowList = <TvShow>[tTvShowModel];

  group('Search tv shows', () {
    test('Should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Right(tTvShowList));

      // act
      provider.fetchTvShowSearch(tQuery);

      // assert
      expect(provider.state, RequestState.loading);
    });

    test(
      'Should change search result data when data is gotten successfully',
      () async {
        // arrange
        when(mockSearchTvShows.execute(tQuery))
            .thenAnswer((_) async => Right(tTvShowList));

        // act
        await provider.fetchTvShowSearch(tQuery);

        // assert
        expect(provider.state, RequestState.loaded);
        expect(provider.searchResult, tTvShowList);
        expect(listenerCallCount, 2);
      },
    );

    test('Should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      // act
      await provider.fetchTvShowSearch(tQuery);

      // assert
      expect(provider.state, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
