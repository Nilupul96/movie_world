import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_world/models/actor_details_model.dart';
import 'package:movie_world/models/cast_model.dart';
import 'package:movie_world/models/movie_details_model.dart';
import 'package:movie_world/models/movie_model.dart';
import 'package:movie_world/models/similar_movie_model.dart';
import 'package:movie_world/models/trending_movie_model.dart';
import 'package:movie_world/ui/screens/base_screen.dart';
import 'package:movie_world/ui/screens/login_screen.dart';
import 'package:movie_world/ui/widgets/alert.dart';
import 'package:movie_world/ui/widgets/progress_dialog.dart';
import 'package:movie_world/utils/const.dart';
import 'package:movie_world/utils/settings.dart';

class MovieApiProvider {
  Client client = Client();
  Future<SimilarMovieModel> getNewToken() async {
    final response = await client
        .get(Uri.parse(baseUrl + "authentication/token/new?api_key=$apiKey"));
    if (response.statusCode == 200) {
      return SimilarMovieModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  Future<SimilarMovieModel> authenticateToken(String token) async {
    final response = await client
        .get(Uri.parse("https://api.themoviedb.org/authenticate/$token"));

    if (response.statusCode == 200) {
      return SimilarMovieModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  Future<SimilarMovieModel> createSession(String token) async {
    final response = await client.post(
        Uri.parse(
          baseUrl + "authentication/session/new?api_key=$apiKey",
        ),
        body: {"request_token": token});

    if (response.statusCode == 200) {
      return SimilarMovieModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  Future<SimilarMovieModel> deleteSession(String id) async {
    final response = await client.post(
        Uri.parse(
          baseUrl + "authentication/session?api_key=$apiKey",
        ),
        body: {"session_id": id});

    if (response.statusCode == 200) {
      return SimilarMovieModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movie details');
    }
  }

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

  Future<TrendingMovieModel> fetchTrendingMovieList(
      int page, String type) async {
    final response = await client.get(Uri.parse(
        baseUrl + "/trending/movie/$type?api_key=$apiKey" + "&page=$page"));

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

  Future<ActorDetailsModel> fetchActorDetails(int id) async {
    final response =
        await client.get(Uri.parse(baseUrl + "/person/$id?api_key=$apiKey"));

    if (response.statusCode == 200) {
      return ActorDetailsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  Future<void> userRegister(
      String email, String passwaord, String username, context) async {
    final _progDig = ProgressDialog(context);
    _progDig.show();
    final response = await client.post(
        Uri.parse(
            "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAp-m-uh8Ded7MdYbmB28FsjKsjOoD700E"),
        body: json.encode({
          "email": email,
          "password": passwaord,
          "returnSecureToken": true
        }));

    var jsonBody = json.decode(response.body)["localId"];
    _progDig.hide();
    if (response.statusCode == 200) {
      final response1 = await client.post(
          Uri.parse(
              "https://movie-world-efeee-default-rtdb.firebaseio.com/User/$jsonBody.json"),
          body: json.encode({
            "email": email,
            "password": passwaord,
            "id": jsonBody,
            "bio": "",
            "imageUrl": ""
          }));

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
    } else {
      Alerts.showMessage(
          context, json.decode(response.body)["error"]["message"]);
    }
  }

  Future<void> userLogin(String email, String passwaord, context) async {
    final _progDig = ProgressDialog(context);
    _progDig.show();
    final response = await client.post(
        Uri.parse(
            "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAp-m-uh8Ded7MdYbmB28FsjKsjOoD700E"),
        body: json.encode({
          "email": email,
          "password": passwaord,
          "returnSecureToken": true
        }));

    var jsonBody = json.decode(response.body);
    print(jsonBody);
    if (response.statusCode == 200) {
      await Settings.setAccessToken(jsonBody["idToken"]);
      await Settings.setRefreshToken(jsonBody["refreshToken"]);
      await Settings.setUserId(jsonBody["localId"]);
      _progDig.hide();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const BaseScreen()));
    } else {
      _progDig.hide();
      Alerts.showMessage(
          context, json.decode(response.body)["error"]["message"]);
    }
  }

  Future<void> updateUser(String email, String passwaord, context) async {
    final _progDig = ProgressDialog(context);
    _progDig.show();
    final response = await client.post(
        Uri.parse(
            "https://identitytoolkit.googleapis.com/v1/accounts:update?key=AIzaSyAp-m-uh8Ded7MdYbmB28FsjKsjOoD700E"),
        body: json.encode({
          "idToken": email,
          "displayName": passwaord,
          "photoUrl": true,
          "deleteAttribute": false
        }));
    var jsonBody = json.decode(response.body);
    print(jsonBody);
    if (response.statusCode == 200) {
      await Settings.setAccessToken(jsonBody["idToken"]);
      await Settings.setRefreshToken(jsonBody["refreshToken"]);
      await Settings.setUserId(jsonBody["localId"]);
      _progDig.hide();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const BaseScreen()));
    } else {
      _progDig.hide();
      Alerts.showMessage(
          context, json.decode(response.body)["error"]["message"]);
    }
  }
}
