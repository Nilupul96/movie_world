import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_world/bloc/movie_details_bloc.dart';
import 'package:movie_world/models/movie_details_model.dart';
import 'package:movie_world/utils/styles.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int id;
  const MovieDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();
    detailsBloc.fetchMovieDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DefaultDarkColor,
        appBar: AppBar(
          backgroundColor: DefaultDarkColor,
        ),
        body: StreamBuilder(
          stream: detailsBloc.movieDetails,
          builder: (context, AsyncSnapshot<MovieDetailsModel> snapshot) {
            if (snapshot.hasData) {
              return _buildBody(snapshot);
            } else if (snapshot.hasError) {
              return const Center(child: Text("No data"));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }

  Widget _buildBody(AsyncSnapshot<MovieDetailsModel> snapshot) {
    return ListView(
      children: [
        SizedBox(
          height: 300.h,
          child: Image.network(
            'https://image.tmdb.org/t/p/w780' + snapshot.data!.backdropPath!,
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
