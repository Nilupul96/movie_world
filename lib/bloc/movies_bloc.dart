import 'package:movie_world/api/repository.dart';
import 'package:movie_world/models/movie_model.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final _repository = Repository();
  final _popularMoviesFetcher = PublishSubject<MovieModel>();
  final _topRatedMoviesFetcher = PublishSubject<MovieModel>();
  final _latestMoviesFetcher = PublishSubject<MovieModel>();
  final _upComingMoviesFetcher = PublishSubject<MovieModel>();

  Stream<MovieModel> get allPopularMovies => _popularMoviesFetcher.stream;
  Stream<MovieModel> get allLatestMovies => _latestMoviesFetcher.stream;
  Stream<MovieModel> get allUpComingMovies => _upComingMoviesFetcher.stream;
  Stream<MovieModel> get allTopRatedMovies => _topRatedMoviesFetcher.stream;

  fetchPopularMovies(int page) async {
    MovieModel itemModel = await _repository.getPopularMovies(page);
    _popularMoviesFetcher.sink.add(itemModel);
  }

  fetchLatestMovies(int page) async {
    MovieModel itemModel = await _repository.getLatestMovies(page);
    _latestMoviesFetcher.sink.add(itemModel);
  }

  fetchTopRatedMovies(int page) async {
    MovieModel itemModel = await _repository.getTopRatedMovies(page);
    _topRatedMoviesFetcher.sink.add(itemModel);
  }

  fetchUpComingMovies(int page) async {
    MovieModel itemModel = await _repository.getUpComingMovies(page);
    _upComingMoviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _popularMoviesFetcher.close();
    _topRatedMoviesFetcher.close();
  }
}

final bloc = MoviesBloc();
