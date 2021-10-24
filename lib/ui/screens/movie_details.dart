import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_world/bloc/movie_cast_bloc.dart';
import 'package:movie_world/bloc/movie_details_bloc.dart';
import 'package:movie_world/models/cast_model.dart';
import 'package:movie_world/models/movie_details_model.dart';
import 'package:movie_world/utils/styles.dart';
import 'package:readmore/readmore.dart';

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
    castBloc.fetchMovieCast(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DefaultDarkColor,
        appBar: AppBar(backgroundColor: DefaultDarkColor, elevation: 0),
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
        ),
        SizedBox(
          height: 15.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            snapshot.data!.title! +
                " (" +
                snapshot.data!.releaseDate!.year.toString() +
                ")",
            style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        _rating(snapshot.data!.voteAverage!),
        SizedBox(
          height: 10.h,
        ),
        _generList(snapshot.data!.genres!),
        SizedBox(
          height: 15.h,
        ),
        _discription(snapshot.data!.overview!),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.0),
          child: Text(
            "cast",
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        _castList()
      ],
    );
  }

  Widget _rating(double rate) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: RatingBar.builder(
        ignoreGestures: true,
        initialRating: rate / 2,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) =>
            const Icon(Icons.star, color: Colors.amber, size: 10),
        onRatingUpdate: (rating) {},
      ),
    );
  }

  Widget _generList(List<dynamic> generList) {
    return SizedBox(
      height: 40.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: generList.length,
          itemBuilder: (context, int index) {
            return Container(
              margin: EdgeInsets.only(left: 20.w),
              padding: EdgeInsets.all(10.0.w),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightBlueAccent),
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                generList[index].name,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            );
          }),
    );
  }

  Widget _discription(String dis) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.all(10.0.w),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.lightBlueAccent),
            borderRadius: BorderRadius.circular(10)),
        child: ReadMoreText(
          dis,
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white),
        ),
      ),
    );
  }

  Widget _castList() {
    return SizedBox(
      height: 100.h,
      child: StreamBuilder(
        stream: castBloc.movieCast,
        builder: (context, AsyncSnapshot<CastModel> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, int index) {
                  return _castTile(snapshot.data!.cast![index].originalName!,
                      snapshot.data!.cast![index].profilePath!);
                });
          } else if (snapshot.hasError) {
            return const Center(child: Text("No data"));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _castTile(String name, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: 150.h,
        width: 100,
        child: Column(
          children: [
            CircleAvatar(
              radius: 30.h,
              backgroundImage:
                  Image.network('https://image.tmdb.org/t/p/w185' + url).image,
            ),
            Center(
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
