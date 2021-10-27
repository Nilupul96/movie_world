import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:movie_world/api/repository.dart';
import 'package:movie_world/models/actor_details_model.dart';
import 'package:movie_world/models/cast_model.dart';
import 'package:movie_world/utils/styles.dart';
import 'package:readmore/readmore.dart';

class ActorDetailsScreen extends StatefulWidget {
  final Cast actor;
  const ActorDetailsScreen({Key? key, required this.actor}) : super(key: key);

  @override
  _ActorDetailsScreenState createState() => _ActorDetailsScreenState();
}

class _ActorDetailsScreenState extends State<ActorDetailsScreen> {
  ActorDetailsModel actorDetails = ActorDetailsModel();
  bool _isPageLoading = true;
  @override
  void initState() {
    super.initState();
    getActorDetails(widget.actor.id!);
  }

  getActorDetails(int id) async {
    final _repository = Repository();
    actorDetails = await _repository.getActorDetails(id);
    setState(() {
      _isPageLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultDarkColor,
      appBar: AppBar(
        backgroundColor: DefaultDarkColor,
        elevation: 0,
        title: Text(
          widget.actor.name!,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: _isPageLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Center(
                    child: CircleAvatar(
                  radius: 100.h,
                  backgroundImage: NetworkImage(
                      'https://image.tmdb.org/t/p/w185' +
                          widget.actor.profilePath!),
                )),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, bottom: 10.h),
                  child: Text(
                    "Date of birth:" +
                        DateFormat('yyyy-MM-dd').format(actorDetails.birthday!),
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, bottom: 10.h),
                  child: Text(
                    "Place of birth:" + actorDetails.placeOfBirth!,
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ),
                _rating(actorDetails.popularity! / 2),
                _discription(actorDetails.biography!)
              ],
            ),
    );
  }

  Widget _discription(String dis) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.all(10.0.w),
        decoration: BoxDecoration(
            color: Color(0xff24243b),
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
}
