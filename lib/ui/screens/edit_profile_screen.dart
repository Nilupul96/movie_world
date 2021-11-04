import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_world/ui/screens/base_screen.dart';
import 'package:movie_world/ui/screens/profile_screen.dart';
import 'package:movie_world/ui/widgets/text_field.dart';
import 'package:movie_world/utils/styles.dart';

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  final String bio;
  const EditProfileScreen(
      {Key? key, required this.name, required this.email, required this.bio})
      : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isProfileLoading = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _bio = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _bioFocus = FocusNode();

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void initState() {
    super.initState();
    _email.text = widget.email;
    _name.text = widget.name;
    _bio.text = widget.bio;
    getProfileDetails();
  }

  getProfileDetails() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DefaultDarkColor,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: DefaultDarkColor,
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: Text(
              "Edit profile",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        body: ListView(
          children: [
            SizedBox(height: 20.h),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 170.h,
                    height: 170.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Color(0XFFFC6748), width: 2.0),
                        borderRadius: BorderRadius.circular(180.0)),
                    child: Padding(
                        padding: EdgeInsets.all(20.h * 4.0 / 6.8),
                        child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 50.h,
                            backgroundImage:
                                Image.asset("./images/profile.jpg").image)),
                  ),
                  const Positioned(
                      bottom: 0,
                      left: 140 / 2,
                      child: CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 30,
                              )))),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            LyfTextFormField(
              labelText: "Username",
              textEditingController: _name,
              focusNode: _nameFocus,
              onFieldSubmitted: (term) {
                _fieldFocusChange(context, _nameFocus, _emailFocus);
              },
            ),
            SizedBox(height: 20.h),
            LyfTextFormField(
              labelText: "Email",
              textEditingController: _email,
              focusNode: _emailFocus,
              onFieldSubmitted: (term) {
                _fieldFocusChange(context, _emailFocus, _bioFocus);
              },
            ),
            SizedBox(height: 20.h),
            _bioText(),
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
                      builder: (context) => const BaseScreen(
                            index: 2,
                          ))),
                  child: const Text("Save",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      )),
                )),
          ],
        ));
  }

  Widget _bioText() {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: TextFormField(
        controller: _bio,
        focusNode: _bioFocus,
        minLines: 5,
        maxLines: 6,
        textInputAction: TextInputAction.done,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        decoration: const InputDecoration(
          labelStyle: TextStyle(
              color: Colors.lightBlueAccent, fontWeight: FontWeight.w500),
          labelText: "Bio",
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.transparent,
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.lightBlueAccent, width: 2.0)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.lightBlueAccent, width: 2.0)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2.0)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.lightBlueAccent, width: 2.0)),
        ),

        keyboardType: TextInputType.multiline,
        //onTap: onTap,
      ),
    );
  }
}
