import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_world/api/repository.dart';
import 'package:movie_world/models/trending_movie_model.dart';
import 'package:movie_world/ui/screens/movie_details.dart';
import 'package:movie_world/ui/widgets/grid_view_item.dart';
import 'package:movie_world/ui/widgets/progress_view.dart';
import 'package:movie_world/utils/styles.dart';

class TrendingMoviesScreen extends StatefulWidget {
  const TrendingMoviesScreen({Key? key}) : super(key: key);

  @override
  _TrendingMoviesScreenState createState() => _TrendingMoviesScreenState();
}

class _TrendingMoviesScreenState extends State<TrendingMoviesScreen> {
  bool isPageLoading = true;
  bool isListLoading = true;
  bool _pageEnd = false;
  int? page = 1;
  int currentIndex = 0;
  final List<String> _type = ["day", "week"];
  List<TrendingMovieResult> trendingMovieList = [];

  @override
  void initState() {
    super.initState();
    getTrendingMovieList(1, 0);
  }

  getTrendingMovieList(int page, int index) async {
    final _repository = Repository();
    TrendingMovieModel response =
        await _repository.getTrendingMovieList(page, _type[index]);
    for (var element in response.results!) {
      trendingMovieList.add(element);
    }

    print(trendingMovieList.length);
    setState(() {
      isPageLoading = false;
      isListLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          backgroundColor: DefaultDarkColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: DefaultDarkColor,
            elevation: 0,
            bottom: TabBar(
                onTap: (index) {
                  isPageLoading = true;
                  setState(() {
                    currentIndex = index;
                  });
                  trendingMovieList.clear();
                  getTrendingMovieList(1, currentIndex);
                },
                indicatorColor: Colors.lightBlueAccent,
                indicatorWeight: 4,
                tabs: const [
                  Tab(
                    text: "Today",
                  ),
                  Tab(
                    text: "This Week",
                  )
                ]),
            title: const Text(
              "Trending Movies",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (!isListLoading &&
                      scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                    if (!_pageEnd) {
                      isListLoading = true;
                      page = page! + 1;
                      getTrendingMovieList(page!, currentIndex);
                    }
                  }
                  return true;
                },
                child: _buildBody()),
          ),
        ));
  }

  Widget _buildBody() {
    return isPageLoading
        ? const Center(
            child: ProgressView(),
          )
        : trendingMovieList.isEmpty
            ? const Center(
                child: Text("No data"),
              )
            : _buildList();
  }

  Widget _buildList() {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        GridView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: trendingMovieList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 10 / 14, crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MovieDetailsScreen(
                            id: trendingMovieList[index].id!,
                          ))),
                  child:
                      GridViewItem(url: trendingMovieList[index].posterPath!));
            }),
        isListLoading
            ? const Center(child: CircularProgressIndicator())
            : const SizedBox()
      ],
    );
  }
}
