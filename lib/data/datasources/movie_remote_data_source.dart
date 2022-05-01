import 'dart:convert';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/data/models/movie_response.dart';
import 'package:ditonton/common/exception.dart';
import 'package:http/http.dart' as http;

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();

  Future<List<MovieModel>> getPopularMovies();

  Future<List<MovieModel>> getTopRatedMovies();

  Future<MovieDetailModel> getMovieDetail(int id);

  Future<List<MovieModel>> getMovieRecommendations(int id);

  Future<List<MovieModel>> searchMovies(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  static const baseUrl = 'https://api.themoviedb.org/3';
  static const apiKey = 'api_key=1f93a5b4410a2cf0e46efda561c514cf';

  final http.Client client;

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final uri = Uri.parse('$baseUrl/movie/now_playing?$apiKey');

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movies;
    }

    throw ServerException('Internal Server Error');
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final uri = Uri.parse('$baseUrl/movie/popular?$apiKey');

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movies;
    }

    throw ServerException('Internal Server Error');
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final uri = Uri.parse('$baseUrl/movie/top_rated?$apiKey');

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movies;
    }

    throw ServerException('Internal Server Error');
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int id) async {
    final uri = Uri.parse('$baseUrl/movie/$id?$apiKey');

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(json.decode(response.body));
    }

    throw ServerException('Internal Server Error');
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    final uri = Uri.parse('$baseUrl/movie/$id/recommendations?$apiKey');

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movies;
    }

    throw ServerException('Internal Server Error');
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final uri = Uri.parse('$baseUrl/search/movie?query=$query&$apiKey');

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movies;
    }

    throw ServerException('Internal Server Error');
  }
}
