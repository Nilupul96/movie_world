import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_world/api/repository.dart';
import 'package:movie_world/bloc/movies_bloc.dart';
import 'package:movie_world/models/movie_model.dart';
import 'package:movie_world/models/trending_movie_model.dart';
import 'package:movie_world/ui/screens/movie_details.dart';
import 'package:movie_world/ui/screens/movie_list_screen.dart';
import 'package:movie_world/utils/styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TrendingMovieModel> _trendingMovieList = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    getTrendingMovies();
    bloc.fetchUpComingMovies(1);
    bloc.fetchPopularMovies(1);
    bloc.fetchTopRatedMovies(1);
  }

  getTrendingMovies() async {
    final repo = Repository();
    var response = await repo.getTrendingMovieList(1);
    _trendingMovieList.add(response);
    setState(() {
      _isLoading = false;
    });
    bloc.fetchUpComingMovies(1);
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DefaultDarkColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 20.w,
          title: const Text(
            "Home",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: DefaultDarkColor,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ))
          ],
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ListView(
              children: [
                const Text(
                  "Trending movies",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                _isLoading ? const SizedBox() : _trendingMoviesTile(),
                _menuItem(
                  "Popular Movies",
                  bloc.allPopularMovies,
                ),
                _menuItem("Top Rated Movies", bloc.allTopRatedMovies),
                _menuItem("Upcoming Movies", bloc.allUpComingMovies),
                // _menuItem("latest movies", bloc.allLatestMovies),
              ],
            )));
  }

  Widget _menuItem(String title, stream) {
    return SizedBox(
      height: 280.h,
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MovieListScreen(
                            movieType: title,
                          )));
                },
                child: const Text(
                  "See all",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
              child: StreamBuilder(
                  stream: stream,
                  builder: (context, AsyncSnapshot<MovieModel> snapshot) {
                    print(snapshot.connectionState);
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 6,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MovieDetailsScreen(
                                          id: snapshot
                                              .data!.results![index].id!,
                                        )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(7.0),
                                  child: Image.network(
                                    'https://image.tmdb.org/t/p/w185' +
                                        snapshot
                                            .data!.results![index].posterPath!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text("no data"),
                      );
                    }
                    bloc.fetchUpComingMovies(1);
                    return SizedBox(
                        height: 50,
                        width: 50.h,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ));
                  }))
        ],
      ),
    );
  }

  Widget _trendingMoviesTile() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 2),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: _trendingMovieList[0].results!.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MovieDetailsScreen(
                        id: i.id!,
                      ))),
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w185' + i.posterPath!,
                      fit: BoxFit.cover,
                    )),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
