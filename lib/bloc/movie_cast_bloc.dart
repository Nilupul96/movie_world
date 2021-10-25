import 'package:movie_world/api/repository.dart';
import 'package:movie_world/models/cast_model.dart';
import 'package:rxdart/rxdart.dart';
import 'movie_details_bloc.dart';

class MovieCastBloc {
  final _repository = Repository();
  final _movieDetailsFetcher = PublishSubject<CastModel>();

  Stream<CastModel> get movieCast => _movieDetailsFetcher.stream;

  fetchMovieCast(int id) async {
    CastModel itemModel = await _repository.getMovieCast(id);
    _movieDetailsFetcher.sink.add(itemModel);
  }
}

final castBloc = MovieCastBloc();
