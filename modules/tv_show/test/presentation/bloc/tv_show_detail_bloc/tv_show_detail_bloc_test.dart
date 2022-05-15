import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tvshow.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_show_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvShowDetail, GetTvShowRecommendations])
void main() {
  late TvShowDetailBloc tvShowDetailBloc;
  late MockGetTvShowDetail mockGetTvShowDetail;
  late MockGetTvShowRecommendations mockGetTvShowRecommendations;

  const tId = 1;

  setUp(() {
    mockGetTvShowDetail = MockGetTvShowDetail();
    mockGetTvShowRecommendations = MockGetTvShowRecommendations();
    tvShowDetailBloc = TvShowDetailBloc(
      getTvShowDetail: mockGetTvShowDetail,
      getTvShowRecommendations: mockGetTvShowRecommendations,
    );
  });

  test('Initial state should be empty', () {
    expect(tvShowDetailBloc.state, TvShowDetailEmpty());
  });

  blocTest<TvShowDetailBloc, TvShowDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvShowDetail.execute(tId))
          .thenAnswer((_) async => const Right(testTvShowDetail));

      when(mockGetTvShowRecommendations.execute(tId))
          .thenAnswer((_) async => const Right(testTvShowList));

      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchTvShowDetail(tId)),
    expect: () => [
      TvShowDetailLoading(),
      const TvShowDetailHasData(testTvShowDetail, testTvShowList),
    ],
    verify: (_) {
      verify(mockGetTvShowDetail.execute(tId));
      verify(mockGetTvShowRecommendations.execute(tId));
    },
  );

  blocTest<TvShowDetailBloc, TvShowDetailState>(
    'Should emit [Loading, Error] when get tv show detail is unsuccessful',
    build: () {
      when(mockGetTvShowDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      when(mockGetTvShowRecommendations.execute(tId))
          .thenAnswer((_) async => const Right(testTvShowList));

      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchTvShowDetail(tId)),
    expect: () => [
      TvShowDetailLoading(),
      const TvShowDetailError('Server Failure'),
    ],
    verify: (_) {
      verify(mockGetTvShowDetail.execute(tId));
      verify(mockGetTvShowRecommendations.execute(tId));
    },
  );

  blocTest<TvShowDetailBloc, TvShowDetailState>(
    'Should emit [Loading, Error] when get tv show recommendations is unsuccessful',
    build: () {
      when(mockGetTvShowDetail.execute(tId))
          .thenAnswer((_) async => const Right(testTvShowDetail));

      when(mockGetTvShowRecommendations.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchTvShowDetail(tId)),
    expect: () => [
      TvShowDetailLoading(),
      const TvShowDetailError('Server Failure'),
    ],
    verify: (_) {
      verify(mockGetTvShowDetail.execute(tId));
      verify(mockGetTvShowRecommendations.execute(tId));
    },
  );

  blocTest<TvShowDetailBloc, TvShowDetailState>(
    'Should emit [Loading, Error] when get tv show detail and recommendations is unsuccessful',
    build: () {
      when(mockGetTvShowDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      when(mockGetTvShowRecommendations.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchTvShowDetail(tId)),
    expect: () => [
      TvShowDetailLoading(),
      const TvShowDetailError('Server Failure'),
    ],
    verify: (_) {
      verify(mockGetTvShowDetail.execute(tId));
      verify(mockGetTvShowRecommendations.execute(tId));
    },
  );
}
