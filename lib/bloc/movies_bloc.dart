import 'package:movie_world/api/repository.dart';
import 'package:movie_world/models/popular_movies_model.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<PopularMoviesModel>();

  Stream<PopularMoviesModel> get allPopularMovies => _moviesFetcher.stream;

  fetchPopularMovies(int page) async {
    PopularMoviesModel itemModel = await _repository.getPopularMovies(page);
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

final bloc = MoviesBloc();
