import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_world/api/repository.dart';
import 'package:movie_world/models/movie_model.dart';
import 'package:movie_world/ui/screens/movie_details.dart';
import 'package:movie_world/ui/widgets/grid_view_item.dart';
import 'package:movie_world/ui/widgets/progress_view.dart';
import 'package:movie_world/ui/widgets/search_bar_textField.dart';
import 'package:movie_world/utils/styles.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Result> _movieList = [];
  TextEditingController _search = TextEditingController();
  bool _isListLoading = false;
  bool _pageEnd = false;

  int? page = 1;
  @override
  void initState() {
    super.initState();
  }

  getMovieList(int page, String searchText) async {
    final _repository = Repository();
    var response = await _repository.getSearchMovieList(page, searchText);
    response.results!.forEach((element) {
      _movieList.add(element);
    });
    setState(() {
      _isListLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DefaultDarkColor,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: DefaultDarkColor,
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.only(
              right: 20.w,
            ),
            child: Text(
              "Search",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (!_isListLoading &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
              if (!_pageEnd) {
                _isListLoading = true;
                page = page! + 1;
                getMovieList(page!, _search.text);
              }
            }
            return true;
          },
          child: Stack(
            children: [
              _buildList(),
              Positioned(
                top: 0.h,
                left: 0,
                right: 0,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: SearchBartextField(
                    controller: _search,
                    onChanged: (value) {
                      _movieList.clear();
                      getMovieList(page!, value);
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildList() {
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(height: 60.h),
        _movieList.isNotEmpty
            ? GridView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: _movieList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 9 / 14, crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MovieDetailsScreen(
                                id: _movieList[index].id!,
                              ))),
                      child: GridViewItem(url: _movieList[index].posterPath!));
                })
            : const Center(
                child: Text(
                "No results!",
                style: TextStyle(color: Colors.white),
              )),
        _isListLoading ? const Center(child: ProgressView()) : const SizedBox()
      ],
    );
  }
}
