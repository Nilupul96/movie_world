import 'dart:convert';
import 'package:http/http.dart';
import 'package:movie_world/models/popular_movies_model.dart';
import 'package:movie_world/utils/const.dart';

class MovieApiProvider {
  Client client = Client();

  Future<PopularMoviesModel> fetchPopularMovieList(int page) async {
    final response = await client.get(
        Uri.parse(baseUrl + "movie/popular?api_key=$apiKey" + "&page=$page"));
    print(response.body.toString());
    if (response.statusCode == 200) {
      return PopularMoviesModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
