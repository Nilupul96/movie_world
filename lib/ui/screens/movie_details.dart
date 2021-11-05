import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_world/api/repository.dart';
import 'package:movie_world/bloc/movie_cast_bloc.dart';
import 'package:movie_world/bloc/movie_details_bloc.dart';
import 'package:movie_world/models/cast_model.dart';
import 'package:movie_world/models/movie_details_model.dart';
import 'package:movie_world/models/similar_movie_model.dart';
import 'package:movie_world/ui/screens/actor_details_screen.dart';
import 'package:movie_world/ui/widgets/progress_view.dart';
import 'package:movie_world/utils/styles.dart';
import 'package:readmore/readmore.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int id;
  const MovieDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  List<SimilarMovieResult> similarMovieList = [];
  bool isSimilarMoviesLoading = true;
  @override
  void initState() {
    super.initState();
    detailsBloc.fetchMovieDetails(widget.id);
    castBloc.fetchMovieCast(widget.id);
    getSimilarMovies(widget.id);
  }

  getSimilarMovies(int id) async {
    final _repository = Repository();
    var response = await _repository.getSimilarMovieList(id);
    response.results!.forEach((element) {
      similarMovieList.add(element);
    });
    print(similarMovieList.length);
    setState(() {
      isSimilarMoviesLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DefaultDarkColor,
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
    return Stack(
      children: [
        ListView(
          children: [
            SizedBox(
              height: 280.h,
              child: Image.network(
                'https://image.tmdb.org/t/p/w780' +
                    snapshot.data!.backdropPath!,
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
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600)),
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
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500)),
              ),
            ),
            _castList(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.0),
              child: Text(
                "Similar movies",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500)),
              ),
            ),
            _buildSimilarMovieList(),
            SizedBox(
              height: 30.h,
            )
          ],
        ),
        Positioned(
            top: 20.h,
            left: 0.w,
            child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30.h,
                ))),
      ],
    );
  }

  Widget _buildSimilarMovieList() {
    return isSimilarMoviesLoading
        ? const Center(
            child: ProgressView(),
          )
        : similarMovieList.isNotEmpty
            ? SizedBox(
                height: 200.h,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, int index) {
                      return GestureDetector(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MovieDetailsScreen(
                                      id: similarMovieList[index].id!,
                                    ))),
                        child: SizedBox(
                          width: 120.w,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(7.0),
                                  child: SizedBox(
                                    width: 120.w,
                                    height: 150.h,
                                    child: Image.network(
                                        'https://image.tmdb.org/t/p/w780' +
                                            similarMovieList[index]
                                                .posterPath!),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Expanded(
                                  child: Text(similarMovieList[index].title!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 11, color: Colors.white)),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
            : const Center(child: Text("No similar Movies"));
  }

  Widget _rating(double rate) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: RatingBar.builder(
        unratedColor: Colors.blueGrey,
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
            color: const Color(0xff24243b),
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
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ActorDetailsScreen(
                              actor: snapshot.data!.cast![index],
                            ))),
                    child: _castTile(snapshot.data!.cast![index].originalName!,
                        snapshot.data!.cast![index].profilePath!),
                  );
                });
          } else if (snapshot.hasError) {
            return const Center(child: Text("No data"));
          }
          return const Center(child: ProgressView());
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
