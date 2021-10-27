import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_world/ui/screens/base_screen.dart';
import 'package:movie_world/ui/screens/home_screen.dart';
import 'package:movie_world/ui/screens/register_screen.dart';
import 'package:movie_world/ui/widgets/text_field.dart';
import 'package:movie_world/utils/styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultDarkColor,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LyfTextFormField(
              labelText: "Email",
              textEditingController: _email,
              focusNode: _emailFocus,
              onFieldSubmitted: (term) {
                _fieldFocusChange(context, _emailFocus, _passwordFocus);
              },
            ),
            LyfTextFormField(
              labelText: "Password",
              isPassword: true,
              textEditingController: _password,
              focusNode: _passwordFocus,
              onFieldSubmitted: (term) {
                _passwordFocus.unfocus();
              },
            ),
            SizedBox(
              height: 20.w,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0)),
                      padding: const EdgeInsets.all(10),
                      primary: const Color(0xffe93f3f)),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => BaseScreen()));
                  },
                  child: const Text("Log in",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      )),
                )),
            SizedBox(
              height: 40.w,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 17.sp, color: Colors.grey),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                          fontSize: 17.sp,
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.w800),
                    ),
                  )
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}