import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:xpert_iptv/providers/series_stream_episode_provider.dart';
import 'package:xpert_iptv/screens/player_screen.dart';
import 'package:xpert_iptv/screens/yt_player_screen.dart';
import 'package:xpert_iptv/utils/helper.dart';
import 'package:xpert_iptv/utils/network_client.dart';
import '../models/series_stream.dart';

class SeriesStreamEpisodeScreen extends StatefulWidget {
  final SeriesStream seriesStream;
  const SeriesStreamEpisodeScreen({Key? key, required this.seriesStream})
      : super(key: key);

  @override
  State<SeriesStreamEpisodeScreen> createState() =>
      _SeriesStreamEpisodeScreenState();
}

class _SeriesStreamEpisodeScreenState extends State<SeriesStreamEpisodeScreen> {
  int selectedSeason = 1;
  @override
  void initState() {
    final sSP =
        Provider.of<SeriesStreamEpisodeProvider>(context, listen: false);
    sSP.seriesStreamEpisodeList.clear();
    sSP.seasonsCount = 0;
    sSP.loadSeriesStreamEpisodeList(widget.seriesStream.seriesId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  '${widget.seriesStream.cover}',
                  width: 480.w,
                  height: 312.h,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.black45,
                    height: 80.h,
                  ),
                ),
                Positioned(
                  top: 250.h,
                  left: 24.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.seriesStream.name}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        '${widget.seriesStream.releaseDate}',
                        style: TextStyle(
                          color: const Color(0xffB4B5BA),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingBar(
                    initialRating: widget.seriesStream.rating5Based.toDouble(),
                    direction: Axis.horizontal,
                    itemSize: 40.w,
                    ignoreGestures: true,
                    allowHalfRating: true,
                    itemCount: 5,
                    ratingWidget: RatingWidget(
                      full: const Icon(Icons.star, color: Colors.orange),
                      half: const Icon(
                        Icons.star_half,
                        color: Colors.orange,
                      ),
                      empty: const Icon(
                        Icons.star_outline,
                        color: Colors.orange,
                      ),
                    ),
                    onRatingUpdate: (double value) {},
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    '${widget.seriesStream.genre}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    '${widget.seriesStream.plot}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => YoutubePlayerPage(
                              url: '${widget.seriesStream.youtubeTrailer}',
                            ),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xffFF002E),
                        padding: EdgeInsets.symmetric(vertical: 25.h),
                        textStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: const Text(
                        'Watch Trailer',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Season',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Consumer<SeriesStreamEpisodeProvider>(
                    builder: (context, ssep, child) => ssep.seasonsCount == 0
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            height: 44.h,
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: ssep.seasonsCount,
                              itemBuilder: (context, index) => Container(
                                margin: EdgeInsets.symmetric(horizontal: 5.w),
                                child: TextButton(
                                  onPressed: () {
                                    selectedSeason = index + 1;
                                    ssep.getSeriesStreamEpisodeList(index + 1);
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        selectedSeason == (index + 1)
                                            ? const Color(0xffFF002E)
                                            : const Color(0xff252B44),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.h, horizontal: 20.w),
                                    textStyle: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: Text(
                                    'Season ${index + 1}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Episodes',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Consumer<SeriesStreamEpisodeProvider>(
                    builder: (context, ssep, child) => ssep
                            .seriesStreamEpisodeList.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            height: 150.h,
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: ssep.seriesStreamEpisodeList.length,
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PlayerScreen(
                                        url:
                                            '${Helper.baseUrl}/series/${ssep.username}/${ssep.password}/${ssep.seriesStreamEpisodeList[index].id}.${ssep.seriesStreamEpisodeList[index].containerExtension}'),
                                  ));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                                  width: 120.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 100.h,
                                        width: 120.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                          color: Colors.grey,
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(ssep
                                                .seriesStreamEpisodeList[index]
                                                .movieImage),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          ssep.seriesStreamEpisodeList[index]
                                              .title,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
