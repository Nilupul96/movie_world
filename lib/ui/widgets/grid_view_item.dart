import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridViewItem extends StatefulWidget {
  final String url;
  const GridViewItem({Key? key, required this.url}) : super(key: key);

  @override
  _GridViewItemState createState() => _GridViewItemState();
}

class _GridViewItemState extends State<GridViewItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 10.w, 3.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7.0),
        child: Image.network(
          'https://image.tmdb.org/t/p/w185' + widget.url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
