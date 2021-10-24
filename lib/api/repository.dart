import 'package:movie_world/api/api_provider.dart';
import 'package:movie_world/models/cast_model.dart';
import 'package:movie_world/models/movie_details_model.dart';
import 'package:movie_world/models/movie_model.dart';
import 'package:movie_world/models/trending_movie_model.dart';

class Repository {
  final movieApiProvider = MovieApiProvider();

  Future<MovieModel> getPopularMovies(int page) =>
      movieApiProvider.fetchPopularMovieList(page);

  Future<MovieModel> getLatestMovies(int page) =>
      movieApiProvider.fetchLatestMovieList(page);

  Future<MovieModel> getTopRatedMovies(int page) =>
      movieApiProvider.fetchTopRatedMovieList(page);

  Future<MovieModel> getUpComingMovies(int page) =>
      movieApiProvider.fetchUpComingMovieList(page);

  Future<MovieDetailsModel> getMovieDetails(int id) =>
      movieApiProvider.fetchMovieDetails(id);
  Future<CastModel> getMovieCast(int id) => movieApiProvider.fetchMovieCast(id);
  Future<TrendingMovieModel> getTrendingMovieList(int id) =>
      movieApiProvider.fetchTrendingMovieList(id);
}
