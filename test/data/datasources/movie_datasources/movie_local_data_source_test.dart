import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/movie_datasources/movie_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDatabaseHelper mockDatabaseHelper;
  late MovieLocalDataSourceImpl dataSource;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = MovieLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('Add movie to watchlist', () {
    test('Should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertMovieWatchlist(testMovieTable))
          .thenAnswer((_) async => 1);

      // act
      final result = await dataSource.insertMovieWatchlist(testMovieTable);

      // assert
      expect(result, 'Added Movie to Watchlist');
    });

    test('Should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertMovieWatchlist(testMovieTable))
          .thenThrow(Exception());

      // act
      final call = dataSource.insertMovieWatchlist(testMovieTable);

      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Remove movie from watchlist', () {
    test('Should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeMovieWatchlist(testMovieTable))
          .thenAnswer((_) async => 1);

      // act
      final result = await dataSource.removeMovieWatchlist(testMovieTable);

      // assert
      expect(result, 'Removed Movie from Watchlist');
    });

    test('Should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeMovieWatchlist(testMovieTable))
          .thenThrow(Exception());

      // act
      final call = dataSource.removeMovieWatchlist(testMovieTable);

      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get movie detail by id', () {
    const tId = 1;

    test('Should return Movie Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(tId))
          .thenAnswer((_) async => testMovieMap);

      // act
      final result = await dataSource.getMovieById(tId);

      // assert
      expect(result, testMovieTable);
    });

    test('Should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(tId)).thenAnswer((_) async => null);

      // act
      final result = await dataSource.getMovieById(tId);

      // assert
      expect(result, null);
    });
  });

  group('Get watchlist movies', () {
    test('Should return list of MovieTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieMap]);

      // act
      final result = await dataSource.getWatchlistMovies();

      // assert
      expect(result, [testMovieTable]);
    });
  });
}
