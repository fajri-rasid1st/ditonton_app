import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show_entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/add_tv_show_watchlist.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/delete_tv_show_watchlist.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_tv_show_detail.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_tv_show_recommendations.dart';
import 'package:ditonton/domain/usecases/tv_show_usecases/get_tv_show_watchlist_status.dart';
import 'package:ditonton/presentation/provider/tv_show_notifiers/tv_show_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_show_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvShowDetail,
  GetTvShowRecommendations,
  GetTvShowWatchListStatus,
  AddTvShowWatchlist,
  DeleteTvShowWatchlist,
])
void main() {
  late TvShowDetailNotifier provider;
  late MockGetTvShowDetail mockGetTvShowDetail;
  late MockGetTvShowRecommendations mockGetTvShowRecommendations;
  late MockGetTvShowWatchListStatus mockGetTvShowWatchListStatus;
  late MockAddTvShowWatchlist mockAddTvShowWatchlist;
  late MockDeleteTvShowWatchlist mockDeleteTvShowWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;

    mockGetTvShowDetail = MockGetTvShowDetail();
    mockGetTvShowRecommendations = MockGetTvShowRecommendations();
    mockGetTvShowWatchListStatus = MockGetTvShowWatchListStatus();
    mockAddTvShowWatchlist = MockAddTvShowWatchlist();
    mockDeleteTvShowWatchlist = MockDeleteTvShowWatchlist();

    provider = TvShowDetailNotifier(
      getTvShowDetail: mockGetTvShowDetail,
      getTvShowRecommendations: mockGetTvShowRecommendations,
      getTvShowWatchListStatus: mockGetTvShowWatchListStatus,
      addTvShowWatchlist: mockAddTvShowWatchlist,
      deleteTvShowWatchlist: mockDeleteTvShowWatchlist,
    )..addListener(() => listenerCallCount++);
  });

  const tId = 1;

  const tTvShow = TvShow(
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
  );

  final tTvShows = <TvShow>[tTvShow];

  void _arrangeUsecase() {
    when(mockGetTvShowDetail.execute(tId))
        .thenAnswer((_) async => const Right(testTvShowDetail));

    when(mockGetTvShowRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvShows));
  }

  group('Get tv show detail', () {
    test('Should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();

      // act
      await provider.fetchTvShowDetail(tId);

      // assert
      verify(mockGetTvShowDetail.execute(tId));
      verify(mockGetTvShowRecommendations.execute(tId));
    });

    test('Should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();

      // act
      provider.fetchTvShowDetail(tId);

      // assert
      expect(provider.tvShowState, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('Should change tv show when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();

      // act
      await provider.fetchTvShowDetail(tId);

      // assert
      expect(provider.tvShowState, RequestState.loaded);
      expect(provider.tvShow, testTvShowDetail);
      expect(listenerCallCount, 3);
    });

    test(
      'Should change recommendation tv shows when data is gotten successfully',
      () async {
        // arrange
        _arrangeUsecase();

        // act
        await provider.fetchTvShowDetail(tId);

        // assert
        expect(provider.tvShowState, RequestState.loaded);
        expect(provider.tvShowRecommendations, tTvShows);
      },
    );
  });

  group('Get tv show recommendations', () {
    test('Should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();

      // act
      await provider.fetchTvShowDetail(tId);

      // assert
      verify(mockGetTvShowRecommendations.execute(tId));

      expect(provider.tvShowRecommendations, tTvShows);
    });

    test(
      'Should update recommendation state when data is gotten successfully',
      () async {
        // arrange
        _arrangeUsecase();

        // act
        await provider.fetchTvShowDetail(tId);

        // assert
        expect(provider.recommendationState, RequestState.loaded);
        expect(provider.tvShowRecommendations, tTvShows);
      },
    );

    test('Should update error message when request in successful', () async {
      // arrange
      when(mockGetTvShowDetail.execute(tId))
          .thenAnswer((_) async => const Right(testTvShowDetail));

      when(mockGetTvShowRecommendations.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Failed')));

      // act
      await provider.fetchTvShowDetail(tId);

      // assert
      expect(provider.recommendationState, RequestState.error);
      expect(provider.message, 'Failed');
    });
  });

  group('Get watchlist', () {
    test('Should get the watchlist status', () async {
      // arrange
      when(mockGetTvShowWatchListStatus.execute(1))
          .thenAnswer((_) async => const Right(true));

      // act
      await provider.loadTvShowWatchlistStatus(1);

      // assert
      verify(mockGetTvShowWatchListStatus.execute(1));

      expect(provider.isAddedToWatchlist, true);
    });

    test('Should execute add watchlist when function called', () async {
      // arrange
      when(mockAddTvShowWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => const Right('Success'));

      when(mockGetTvShowWatchListStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => const Right(true));

      // act
      await provider.addTvShowToWatchlist(testTvShowDetail);

      // assert
      verify(mockAddTvShowWatchlist.execute(testTvShowDetail));
    });

    test('Should execute delete watchlist when function called', () async {
      // arrange
      when(mockDeleteTvShowWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => const Right('Removed'));

      when(mockGetTvShowWatchListStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => const Right(false));

      // act
      await provider.removeTvShowFromWatchlist(testTvShowDetail);

      // assert
      verify(mockDeleteTvShowWatchlist.execute(testTvShowDetail));
    });

    test('Should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockAddTvShowWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));

      when(mockGetTvShowWatchListStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => const Right(true));

      // act
      await provider.addTvShowToWatchlist(testTvShowDetail);

      // assert
      verify(mockGetTvShowWatchListStatus.execute(testTvShowDetail.id));

      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('Should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockAddTvShowWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));

      when(mockGetTvShowWatchListStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => const Right(false));

      // act
      await provider.addTvShowToWatchlist(testTvShowDetail);

      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('Should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvShowDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      when(mockGetTvShowRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvShows));

      // act
      await provider.fetchTvShowDetail(tId);

      // assert
      expect(provider.tvShowState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
