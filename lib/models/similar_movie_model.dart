import 'dart:convert';

SimilarMovieModel similarMovieModelFromJson(String str) =>
    SimilarMovieModel.fromJson(json.decode(str));

String similarMovieModelToJson(SimilarMovieModel data) =>
    json.encode(data.toJson());

class SimilarMovieModel {
  SimilarMovieModel({
    this.page,
    this.results,
  });

  int? page;
  List<SimilarMovieResult>? results;

  factory SimilarMovieModel.fromJson(Map<String, dynamic> json) =>
      SimilarMovieModel(
        page: json["page"],
        results:
            List<SimilarMovieResult>.from(json["results"].map((x) => SimilarMovieResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class SimilarMovieResult {
  SimilarMovieResult({
    this.backdropPath,
    this.id,
    this.title,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
  });

  String? backdropPath;
  int? id;
  String? title;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  DateTime? releaseDate;

  factory SimilarMovieResult.fromJson(Map<String, dynamic> json) => SimilarMovieResult(
        backdropPath: json["backdrop_path"],
        id: json["id"],
        title: json["title"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "id": id,
        "title": title,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
      };
}
