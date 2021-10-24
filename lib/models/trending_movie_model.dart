import 'dart:convert';

TrendingMovieModel trendingMovieModelFromJson(String str) =>
    TrendingMovieModel.fromJson(json.decode(str));

String trendingMovieModelToJson(TrendingMovieModel data) =>
    json.encode(data.toJson());

class TrendingMovieModel {
  TrendingMovieModel({
    this.page,
    this.results,
  });

  int? page;
  List<Result>? results;

  factory TrendingMovieModel.fromJson(Map<String, dynamic> json) =>
      TrendingMovieModel(
        page: json["page"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.adult,
    this.id,
    this.voteAverage,
    this.genreIds,
    this.voteCount,
    this.originalTitle,
    this.posterPath,
    this.video,
    this.title,
    this.backdropPath,
    this.overview,
    this.releaseDate,
    this.popularity,
  });

  bool? adult;
  int? id;
  double? voteAverage;
  List<int>? genreIds;
  int? voteCount;
  String? originalTitle;
  String? posterPath;
  bool? video;
  String? title;
  String? backdropPath;
  String? overview;
  DateTime? releaseDate;
  double? popularity;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json["adult"],
        id: json["id"],
        voteAverage: json["vote_average"].toDouble(),
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        voteCount: json["vote_count"],
        originalTitle: json["original_title"],
        posterPath: json["poster_path"],
        video: json["video"],
        title: json["title"],
        backdropPath: json["backdrop_path"],
        overview: json["overview"],
        releaseDate: DateTime.parse(json["release_date"]),
        popularity: json["popularity"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "id": id,
        "vote_average": voteAverage,
        "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
        "vote_count": voteCount,
        "original_title": originalTitle,
        "poster_path": posterPath,
        "video": video,
        "title": title,
        "backdrop_path": backdropPath,
        "overview": overview,
        "release_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "popularity": popularity,
      };
}
