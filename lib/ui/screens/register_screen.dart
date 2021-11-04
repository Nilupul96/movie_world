import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_world/api/repository.dart';
import 'package:movie_world/ui/screens/login_screen.dart';
import 'package:movie_world/ui/widgets/text_field.dart';
import 'package:movie_world/utils/styles.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _userName = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _userNameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  userRegister() async {
    final _repository = Repository();
    await _repository.userRegister(
        _email.text, _password.text, _userName.text, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DefaultDarkColor,
        body: Container(
          decoration: const BoxDecoration(
              color: DefaultDarkColor,
              image: DecorationImage(
                  image: AssetImage("images/sign.jpg"), fit: BoxFit.cover)),
          child: Center(
            child: SingleChildScrollView(
                child: Form(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                  Center(
                    child: Text("Sign Up",
                        style: GoogleFonts.pacifico(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 33.sp,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                  LyfTextFormField(
                    labelText: "Username",
                    textEditingController: _userName,
                    focusNode: _userNameFocus,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(context, _userNameFocus, _emailFocus);
                    },
                  ),
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
                        onPressed: () => userRegister(),
                        child: const Text("Register",
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
                            "If you have an account?",
                            style:
                                TextStyle(fontSize: 17.sp, color: Colors.grey),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                            },
                            child: Text(
                              "Log in",
                              style: TextStyle(
                                  fontSize: 17.sp,
                                  color: Colors.lightBlueAccent,
                                  fontWeight: FontWeight.w800),
                            ),
                          )
                        ],
                      )))
                ]))),
          ),
        ));
  }
}
