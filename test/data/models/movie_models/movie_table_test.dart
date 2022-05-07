import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  group('toJson', () {
    test('Should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = testMovieTable.toJson();

      // assert
      final expectedJsonMap = {
        'id': 1,
        'title': 'title',
        'overview': 'overview',
        'posterPath': 'posterPath',
      };

      expect(result, expectedJsonMap);
    });
  });
}
