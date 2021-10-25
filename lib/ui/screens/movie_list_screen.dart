import 'package:flutter/material.dart';
import 'package:movie_world/bloc/movies_bloc.dart';
import 'package:movie_world/models/movie_model.dart';
import 'package:movie_world/utils/styles.dart';

class MovieListScreen extends StatefulWidget {
  final String movieType;
  const MovieListScreen({Key? key, required this.movieType}) : super(key: key);

  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  bool _isListLoading = false;
  bool _pageEnd = false;
  var stream;
  int? page = 1;
  @override
  void initState() {
    super.initState();
    getMovieList(1);
  }

  getMovieList(int page) async {
    if (widget.movieType == "Popular Movies") {
      stream = bloc.allPopularMovies;
      await bloc.fetchPopularMovies(page);
    } else if (widget.movieType == "Top Rated Movies") {
      stream = bloc.allTopRatedMovies;
      await bloc.fetchTopRatedMovies(page);
    } else if (widget.movieType == "Upcoming Movies") {
      stream = bloc.allUpComingMovies;
      await bloc.fetchUpComingMovies(page);
    }
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
          child: StreamBuilder(
            stream: stream,
            builder: (context, AsyncSnapshot<MovieModel> snapshot) {
              if (snapshot.hasData) {
                return _buildList(snapshot);
              } else if (snapshot.hasError) {
                return const Center(child: Text("No data"));
              }
              return const Center(child: CircularProgressIndicator());
            },
          )),
    );
  }

  Widget _buildList(AsyncSnapshot<MovieModel> snapshot) {
    return ListView(
      children: [
        GridView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data!.results!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7.0),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w185' +
                        snapshot.data!.results![index].posterPath!,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),
        _isListLoading ? const CircularProgressIndicator() : const SizedBox()
      ],
    );
  }
}
