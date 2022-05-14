import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_show_datasources/tv_show_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDatabaseHelper mockDatabaseHelper;
  late TvShowLocalDataSourceImpl dataSource;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvShowLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('Add tv show to watchlist', () {
    test('Should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTvShowWatchlist(testTvShowTable))
          .thenAnswer((_) async => 1);

      // act
      final result = await dataSource.insertTvShowWatchlist(testTvShowTable);

      // assert
      expect(result, 'Added Tv Show to Watchlist');
    });

    test('Should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTvShowWatchlist(testTvShowTable))
          .thenThrow(Exception());

      // act
      final call = dataSource.insertTvShowWatchlist(testTvShowTable);

      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Remove tv show from watchlist', () {
    test('Should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTvShowWatchlist(testTvShowTable))
          .thenAnswer((_) async => 1);

      // act
      final result = await dataSource.removeTvShowWatchlist(testTvShowTable);

      // assert
      expect(result, 'Removed Tv Show from Watchlist');
    });

    test('Should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTvShowWatchlist(testTvShowTable))
          .thenThrow(Exception());

      // act
      final call = dataSource.removeTvShowWatchlist(testTvShowTable);

      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get tv show detail by id', () {
    const tId = 1;

    test('Should return Tv Show Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getTvShowById(tId))
          .thenAnswer((_) async => testTvShowMap);

      // act
      final result = await dataSource.getTvShowById(tId);

      // assert
      expect(result, testTvShowTable);
    });

    test('Should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTvShowById(tId)).thenAnswer((_) async => null);

      // act
      final result = await dataSource.getTvShowById(tId);

      // assert
      expect(result, null);
    });

    test('Should throw DatabaseException when failed', () async {
      // arrange
      when(mockDatabaseHelper.getTvShowById(tId)).thenThrow(Exception());

      // act
      final call = dataSource.getTvShowById(tId);

      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get watchlist tv shows', () {
    test('Should return list of Tv Show Table from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvShows())
          .thenAnswer((_) async => [testTvShowMap]);

      // act
      final result = await dataSource.getWatchlistTvShows();

      // assert
      expect(result, [testTvShowTable]);
    });

    test('Should throw DatabaseException when failed', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvShows()).thenThrow(Exception());

      // act
      final call = dataSource.getWatchlistTvShows();

      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });
}
