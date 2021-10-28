import 'package:flutter/material.dart';
import 'package:movie_world/api/repository.dart';
import 'package:movie_world/bloc/movies_bloc.dart';
import 'package:movie_world/models/movie_model.dart';
import 'package:movie_world/ui/screens/movie_details.dart';
import 'package:movie_world/ui/widgets/grid_view_item.dart';
import 'package:movie_world/ui/widgets/progress_view.dart';
import 'package:movie_world/utils/styles.dart';

class MovieListScreen extends StatefulWidget {
  final String movieType;
  const MovieListScreen({Key? key, required this.movieType}) : super(key: key);

  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  List<Result> _movieList = [];

  bool _isListLoading = false;
  bool _pageEnd = false;

  int? page = 1;
  @override
  void initState() {
    super.initState();
    getMovieList(1);
  }

  getMovieList(int page) async {
    final _repository = Repository();
    var response;
    if (widget.movieType == "Popular Movies") {
      response = await _repository.getPopularMovies(page);
    } else if (widget.movieType == "Top Rated Movies") {
      response = await _repository.getTopRatedMovies(page);
    } else if (widget.movieType == "Upcoming Movies") {
      response = await _repository.getUpComingMovies(page);
    }
    response.results!.forEach((element) {
      _movieList.add(element);
    });
    print(_movieList.length);
    setState(() {
      _isListLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DefaultDarkColor,
        appBar: AppBar(
          backgroundColor: DefaultDarkColor,
          title: Text(widget.movieType),
          elevation: 0,
        ),
        body: NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (!_isListLoading &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                if (!_pageEnd) {
                  _isListLoading = true;
                  page = page! + 1;
                  getMovieList(page!);
                }
              }
              return true;
            },
            child: _buildList()));
  }

  Widget _buildList() {
    return ListView(
      children: [
        GridView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: _movieList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 9 / 14, crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MovieDetailsScreen(
                            id: _movieList[index].id!,
                          ))),
                  child: GridViewItem(url: _movieList[index].posterPath!));
            }),
        _isListLoading ? const Center(child: ProgressView()) : const SizedBox()
      ],
    );
  }
}
