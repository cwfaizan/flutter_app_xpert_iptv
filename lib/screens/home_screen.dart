import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xpert_iptv/screens/settings_screen.dart';
import 'package:xpert_iptv/screens/tv_category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: RPadding(
          padding: REdgeInsets.all(16),
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/images/icons/1.svg',
                fit: BoxFit.fill,
                height: 0.20.sh,
                width: double.infinity,
              ),
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? Column(
                      children: [
                        homeItem(
                          const Color.fromARGB(255, 175, 50, 28),
                          Icons.tv,
                          'Live TV',
                          () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const TvCategoryScreen(
                                  streamCategory: 'get_live_categories',
                                  streamType: StreamType.liveTv,
                                ),
                              ),
                            );
                          },
                          double.infinity,
                          0.23.sh,
                        ),
                        homeItem(
                          const Color.fromARGB(255, 120, 130, 31),
                          Icons.movie,
                          'Movies',
                          () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const TvCategoryScreen(
                                  streamCategory: 'get_vod_categories',
                                  streamType: StreamType.movies,
                                ),
                              ),
                            );
                          },
                          double.infinity,
                          0.23.sh,
                        ),
                        homeItem(
                          const Color.fromARGB(255, 23, 116, 162),
                          Icons.gamepad,
                          'Series',
                          () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const TvCategoryScreen(
                                  streamCategory: 'get_series_categories',
                                  streamType: StreamType.series,
                                ),
                              ),
                            );
                          },
                          double.infinity,
                          0.23.sh,
                        ),
                        homeItem(
                          const Color.fromARGB(255, 23, 162, 35),
                          Icons.settings,
                          'Settings',
                          () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SettingsScreen(),
                              ),
                            );
                          },
                          double.infinity,
                          0.23.sh,
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        homeItem(
                          const Color.fromARGB(255, 175, 50, 28),
                          Icons.tv,
                          'Live TV',
                          () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const TvCategoryScreen(
                                  streamCategory: 'get_live_categories',
                                  streamType: StreamType.liveTv,
                                ),
                              ),
                            );
                          },
                          MediaQuery.of(context).size.width / 3.2,
                          0.60.sh,
                        ),
                        homeItem(
                          const Color.fromARGB(255, 120, 130, 31),
                          Icons.movie,
                          'Movies',
                          () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const TvCategoryScreen(
                                  streamCategory: 'get_vod_categories',
                                  streamType: StreamType.movies,
                                ),
                              ),
                            );
                          },
                          MediaQuery.of(context).size.width / 3.2,
                          0.60.sh,
                        ),
                        homeItem(
                          const Color.fromARGB(255, 23, 116, 162),
                          Icons.gamepad,
                          'Series',
                          () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const TvCategoryScreen(
                                  streamCategory: 'get_series_categories',
                                  streamType: StreamType.series,
                                ),
                              ),
                            );
                          },
                          MediaQuery.of(context).size.width / 3.2,
                          0.60.sh,
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget homeItem(final color, IconData icon, String title, final onClick,
      double width, double height) {
    return InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.circular(15.r),
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.symmetric(vertical: 7.h, horizontal: 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 60.sm,
              color: Colors.white,
            ),
            SizedBox(height: 20.h),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
    );
  }
}
