import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_world/ui/screens/edit_profile_screen.dart';
import 'package:movie_world/ui/screens/home_screen.dart';
import 'package:movie_world/ui/screens/login_screen.dart';
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
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomeScreen())),
              child: GestureDetector(
                onTap: () => ConfirmationPopup.showMessage(
                    context, "Do you want to logout?",
                    onCloseCallback: () => Navigator.of(context)
                        .pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (route) => false)),
                child: Container(
                    padding: EdgeInsets.only(right: 20.w, top: 15.h),
                    color: Colors.transparent,
                    child: const Icon(Icons.logout, color: Colors.white)),
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
            _bio(),
            SizedBox(height: 30.h),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0)),
                      padding: const EdgeInsets.all(10),
                      primary: const Color(0xffe93f3f)),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const EditProfileScreen(
                            name: "Nilupul",
                            email: "nilupul@gmail.com",
                            bio: "",
                          ))),
                  child: const Text("Edit",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      )),
                )),
          ],
        ));
  }

  Widget _bio() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: const Color(0xff24243b),
        border: Border.all(color: Colors.lightBlueAccent),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Text("Username:  Nilupul",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
          ),
          SizedBox(height: 10.h),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text("Email:  nilupul@gmail.com",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
          ),
          SizedBox(height: 10.h),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text("Bio:",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
