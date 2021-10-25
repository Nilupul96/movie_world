import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_world/ui/screens/home_screen.dart';
import 'package:movie_world/ui/screens/movie_list_screen.dart';
import 'package:movie_world/ui/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: () => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              routes: <String, WidgetBuilder>{
                "/homeScreen": (BuildContext c) => const HomeScreen(),
                "/movieListScreen": (BuildContext c) => const MovieListScreen(
                      movieType: "Popular Movies",
                    ),
              },
              home: const SplashScreen(),
            ));
  }
}
