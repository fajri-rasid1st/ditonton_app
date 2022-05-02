import 'dart:convert';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/tv_show_models/tv_show_detail_model.dart';
import 'package:ditonton/data/models/tv_show_models/tv_show_model.dart';
import 'package:ditonton/data/models/tv_show_models/tv_show_response.dart';
import 'package:http/http.dart' as http;

abstract class TvShowRemoteDataSource {
  Future<List<TvShowModel>> getOnTheAirTvShows();

  Future<List<TvShowModel>> getPopularTvShows();

  Future<List<TvShowModel>> getTopRatedTvShows();

  Future<TvShowDetailModel> getTvShowDetail(int id);

  Future<List<TvShowModel>> getTvShowRecommendations(int id);

  Future<List<TvShowModel>> searchTvShows(String query);

  Future<EpisodeModel> getTvShowEpisodeDetail(
    int id,
    int seasonNumber,
    int episodeNumber,
  );
}

class TvShowRemoteDataSourceImpl implements TvShowRemoteDataSource {
  final http.Client client;

  TvShowRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvShowModel>> getOnTheAirTvShows() async {
    final uri = Uri.parse('$baseUrl/tv/on_the_air?$apiKey');

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).tvShows;
    }

    throw ServerException('Internal Server Error');
  }

  @override
  Future<List<TvShowModel>> getPopularTvShows() async {
    final uri = Uri.parse('$baseUrl/tv/popular?$apiKey');

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).tvShows;
    }

    throw ServerException('Internal Server Error');
  }

  @override
  Future<List<TvShowModel>> getTopRatedTvShows() async {
    final uri = Uri.parse('$baseUrl/tv/top_rated?$apiKey');

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).tvShows;
    }

    throw ServerException('Internal Server Error');
  }

  @override
  Future<TvShowDetailModel> getTvShowDetail(int id) async {
    final uri = Uri.parse('$baseUrl/tv/$id?$apiKey');

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return TvShowDetailModel.fromJson(json.decode(response.body));
    }

    throw ServerException('Internal Server Error');
  }

  @override
  Future<List<TvShowModel>> getTvShowRecommendations(int id) async {
    final uri = Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey');

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).tvShows;
    }

    throw ServerException('Internal Server Error');
  }

  @override
  Future<List<TvShowModel>> searchTvShows(String query) async {
    final uri = Uri.parse('$baseUrl/search/tv?query=$query&$apiKey');

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return TvShowResponse.fromJson(json.decode(response.body)).tvShows;
    }

    throw ServerException('Internal Server Error');
  }

  @override
  Future<EpisodeModel> getTvShowEpisodeDetail(
    int id,
    int seasonNumber,
    int episodeNumber,
  ) async {
    final url =
        '$baseUrl/tv/$id/season/$seasonNumber/episode/$episodeNumber?$apiKey';

    final uri = Uri.parse(url);

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return EpisodeModel.fromJson(json.decode(response.body));
    }

    throw ServerException('Internal Server Error');
  }
}
