import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProgressView extends StatefulWidget {
  const ProgressView({Key? key}) : super(key: key);

  @override
  _ProgressViewState createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(80.0),
      child: SizedBox(
        width: 70.w,
        height: 70.h,
        child: SizedBox(
          height: 60.h,
          width: 60.w,
          child: SpinKitCircle(color: Colors.lightBlueAccent, size: 60.h),
        ),
      ),
    );
  }
}
