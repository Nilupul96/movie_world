import 'dart:convert';
import 'package:http/http.dart';
import 'package:movie_world/models/cast_model.dart';
import 'package:movie_world/models/movie_details_model.dart';
import 'package:movie_world/models/movie_model.dart';
import 'package:movie_world/models/similar_movie_model.dart';
import 'package:movie_world/models/trending_movie_model.dart';
import 'package:movie_world/utils/const.dart';

class MovieApiProvider {
  Client client = Client();

  Future<MovieModel> fetchPopularMovieList(int page) async {
    final response = await client.get(
        Uri.parse(baseUrl + "movie/popular?api_key=$apiKey" + "&page=$page"));

    if (response.statusCode == 200) {
      return MovieModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Popular movies');
    }
  }

  Future<MovieModel> fetchTopRatedMovieList(int page) async {
    final response = await client.get(
        Uri.parse(baseUrl + "movie/top_rated?api_key=$apiKey" + "&page=$page"));

    if (response.statusCode == 200) {
      return MovieModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top rated movies');
    }
  }

  Future<MovieModel> fetchUpComingMovieList(int page) async {
    final response = await client.get(
        Uri.parse(baseUrl + "movie/upcoming?api_key=$apiKey" + "&page=$page"));

    if (response.statusCode == 200) {
      return MovieModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load upComing movies');
    }
  }

  Future<MovieModel> fetchLatestMovieList(int page) async {
    final response = await client.get(
        Uri.parse(baseUrl + "movie/latest?api_key=$apiKey" + "&page=$page"));

    if (response.statusCode == 200) {
      return MovieModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load latest movies');
    }
  }

  Future<TrendingMovieModel> fetchTrendingMovieList(int page) async {
    final response = await client.get(Uri.parse(
        baseUrl + "/trending/movie/day?api_key=$apiKey" + "&page=$page"));

    if (response.statusCode == 200) {
      return TrendingMovieModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load latest movies');
    }
  }

  Future<MovieDetailsModel> fetchMovieDetails(int id) async {
    final response =
        await client.get(Uri.parse(baseUrl + "movie/$id?api_key=$apiKey"));

    if (response.statusCode == 200) {
      return MovieDetailsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  Future<CastModel> fetchMovieCast(int id) async {
    final response = await client
        .get(Uri.parse(baseUrl + "movie/$id/credits?api_key=$apiKey"));

    if (response.statusCode == 200) {
      return CastModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  Future<SimilarMovieModel> fetchSimilarMovieList(int id) async {
    final response = await client
        .get(Uri.parse(baseUrl + "movie/$id/similar?api_key=$apiKey"));

    if (response.statusCode == 200) {
      return SimilarMovieModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}
