import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_world/ui/screens/home_screen.dart';
import 'package:movie_world/ui/widgets/confirmation_popup.dart';
import 'package:movie_world/utils/styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isProfileLoading = true;

  @override
  void initState() {
    super.initState();

    getProfileDetails();
  }

  getProfileDetails() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DefaultDarkColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: DefaultDarkColor,
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.only(right: 20.w, top: 15.h),
            child: Text(
              "profile",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen())),
              child: GestureDetector(
                onTap: () => ConfirmationPopup.showMessage(
                    context, "Do you want to logout?"),
                child: Container(
                  padding: EdgeInsets.only(right: 20.w, top: 15.h),
                  color: Colors.transparent,
                  child: Text("Logout",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      )),
                ),
              ),
            )
          ],
        ),
        body: ListView(
          children: [
            SizedBox(height: 20.h),
            Center(
              child: Container(
                width: 170.h,
                height: 170.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0XFFFC6748), width: 2.0),
                    borderRadius: BorderRadius.circular(180.0)),
                child: Padding(
                    padding: EdgeInsets.all(20.h * 4.0 / 6.8),
                    child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 50.h,
                        backgroundImage:
                            Image.asset("./images/profile.jpg").image)),
              ),
            ),
            SizedBox(height: 20.h),
            Center(
              child: Text("Nilupul",
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500)),
            ),
            SizedBox(height: 20.h),
            _bio(
              "bio",
              " profileProvider.sellerInfo!.description",
            ),
          ],
        ));
  }

  Widget _bio(String title, String dis) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [BoxShadow(color: Color(0xff6E6E6E52), blurRadius: 6.0)]),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title,
              style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600)),
          SizedBox(height: 20.h),
          Text(dis,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400))
        ],
      ),
    );
  }
}
