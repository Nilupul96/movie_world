import 'package:movie_world/api/api_provider.dart';
import 'package:movie_world/models/popular_movies_model.dart';

class Repository {
  final movieApiProvider = MovieApiProvider();

  Future<PopularMoviesModel> getPopularMovies(int page) =>
      movieApiProvider.fetchPopularMovieList(page);
}
