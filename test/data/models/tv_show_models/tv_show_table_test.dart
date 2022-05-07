import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  group('toJson', () {
    test('Should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = testTvShowTable.toJson();

      // assert
      final expectedJsonMap = {
        'id': 1,
        'name': 'name',
        'overview': 'overview',
        'posterPath': 'posterPath',
      };

      expect(result, expectedJsonMap);
    });
  });
}
