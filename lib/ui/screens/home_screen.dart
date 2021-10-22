import 'package:flutter/material.dart';
import 'package:movie_world/bloc/movies_bloc.dart';
import 'package:movie_world/models/popular_movies_model.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: StreamBuilder(
        stream: bloc.allPopularMovies,
        builder: (context, AsyncSnapshot<PopularMoviesModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return const Center(child: Text("No data"));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<PopularMoviesModel> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data!.results!.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
        });
  }
}
