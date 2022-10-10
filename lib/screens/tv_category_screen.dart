import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:xpert_iptv/screens/live_tv_stream_screen.dart';
import '../providers/tv_category_provider.dart';
import 'movies_stream_screen.dart';
import 'series_stream_screen.dart';

enum StreamType { liveTv, movies, series }

// ignore: must_be_immutable
class TvCategoryScreen extends StatefulWidget {
  final StreamType streamType;
  final String streamCategory;
  const TvCategoryScreen(
      {Key? key, required this.streamCategory, required this.streamType})
      : super(key: key);

  @override
  State<TvCategoryScreen> createState() => _TvCategoryScreenState();
}

class _TvCategoryScreenState extends State<TvCategoryScreen> {
  @override
  void initState() {
    final tvCP = Provider.of<TvCategoryProvider>(context, listen: false);
    tvCP.tvCategoryList.clear();
    tvCP.loadCategories(widget.streamCategory);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tvCP = Provider.of<TvCategoryProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/images/icons/1.svg',
              fit: BoxFit.fill,
              height: 0.20.sh,
              width: double.infinity,
            ),
            RPadding(
              padding: REdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => tvCP.search(value),
                decoration: const InputDecoration(hintText: 'Search here...'),
              ),
            ),
            Consumer<TvCategoryProvider>(
              builder: (context, tvCategoryProvider, child) =>
                  tvCategoryProvider.tvCategoryList.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: tvCategoryProvider.tvCategoryList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => widget.streamType ==
                                            StreamType.liveTv
                                        ? LiveTvStreamScreen(
                                            categoryId: tvCategoryProvider
                                                .tvCategoryList[index]
                                                .categoryId,
                                          )
                                        : widget.streamType == StreamType.movies
                                            ? MoviesStreamScreen(
                                                categoryId: tvCategoryProvider
                                                    .tvCategoryList[index]
                                                    .categoryId,
                                              )
                                            : SeriesStreamScreen(
                                                categoryId: tvCategoryProvider
                                                    .tvCategoryList[index]
                                                    .categoryId,
                                              ),
                                  ));
                                },
                                child: Card(
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          tvCategoryProvider
                                              .tvCategoryList[index]
                                              .categoryName,
                                          style: const TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Icon(Icons.navigate_next)
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
