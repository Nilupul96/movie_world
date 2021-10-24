import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_world/bloc/movies_bloc.dart';
import 'package:movie_world/models/movie_model.dart';
import 'package:movie_world/ui/screens/movie_details.dart';
import 'package:movie_world/ui/screens/movie_list_screen.dart';
import 'package:movie_world/utils/styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    bloc.fetchPopularMovies(1);
    // bloc.fetchLatestMovies(1);
    bloc.fetchTopRatedMovies(1);
    bloc.fetchUpComingMovies(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DefaultDarkColor,
        appBar: AppBar(backgroundColor: DefaultDarkColor, elevation: 0),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            children: [
              _menuItem(
                "Popular Movies",
                bloc.allPopularMovies,
              ),
              _menuItem("Top Rated Movies", bloc.allTopRatedMovies),
              _menuItem("Upcoming Movies", bloc.allUpComingMovies),
              // _menuItem("latest movies", bloc.allLatestMovies),
            ],
          ),
        ));
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
                    fontSize: 15,
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
                      fontSize: 14,
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
                    return const CircularProgressIndicator();
                  }))
        ],
      ),
    );
  }
}
