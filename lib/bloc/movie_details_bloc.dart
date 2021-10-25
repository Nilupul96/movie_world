import 'package:movie_world/api/repository.dart';
import 'package:movie_world/models/movie_details_model.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailsBloc {
  final _repository = Repository();
  final _movieDetailsFetcher = PublishSubject<MovieDetailsModel>();

  Stream<MovieDetailsModel> get movieDetails => _movieDetailsFetcher.stream;

  fetchMovieDetails(int id) async {
    MovieDetailsModel itemModel = await _repository.getMovieDetails(id);
    _movieDetailsFetcher.sink.add(itemModel);
  }
}

final detailsBloc = MovieDetailsBloc();
