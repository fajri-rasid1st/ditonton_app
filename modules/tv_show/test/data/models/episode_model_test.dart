import 'package:flutter_test/flutter_test.dart';
import 'package:tv_show/tvshow.dart';

void main() {
  const tEpisodeModel = EpisodeModel(
    airDate: 'airDate',
    episodeNumber: 1,
    name: 'name',
    overview: 'overview',
    stillPath: 'stillPath',
  );

  const tEpisode = Episode(
    airDate: 'airDate',
    episodeNumber: 1,
    name: 'name',
    overview: 'overview',
    stillPath: 'stillPath',
  );

  test('Should be a subclass of Episode entity', () async {
    final result = tEpisodeModel.toEntity();

    expect(result, tEpisode);
  });
}
