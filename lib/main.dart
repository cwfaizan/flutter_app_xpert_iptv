import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:xpert_iptv/models/user_info.dart';
import 'package:xpert_iptv/providers/live_tv_stream_provider.dart';
import 'package:xpert_iptv/providers/password_provider.dart';
import 'package:xpert_iptv/providers/series_stream_episode_provider.dart';
import 'package:xpert_iptv/providers/tv_category_provider.dart';
import 'package:xpert_iptv/screens/home_screen.dart';
import 'package:xpert_iptv/screens/login_screen.dart';
import 'package:xpert_iptv/utils/routes.dart';

import 'providers/account_provider.dart';
import 'providers/movies_stream_provider.dart';
import 'providers/series_stream_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory tempDir = await getTemporaryDirectory();
  Hive
    ..init(tempDir.path)
    ..registerAdapter(UserInfoAdapter());
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  Map<int, Color> colorCodes = const {
    50: Color.fromRGBO(147, 205, 72, .1),
    100: Color.fromRGBO(147, 205, 72, .2),
    200: Color.fromRGBO(147, 205, 72, .3),
    300: Color.fromRGBO(147, 205, 72, .4),
    400: Color.fromRGBO(147, 205, 72, .5),
    500: Color.fromRGBO(147, 205, 72, .6),
    600: Color.fromRGBO(147, 205, 72, .7),
    700: Color.fromRGBO(147, 205, 72, .8),
    800: Color.fromRGBO(147, 205, 72, .9),
    900: Color.fromRGBO(147, 205, 72, 1),
  };

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PasswordProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TvCategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LiveTvStreamProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MoviesStreamProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SeriesStreamProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SeriesStreamEpisodeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AccountProvider(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(480, 853),
        builder: (context, child) => MaterialApp(
          title: 'Xpert IPTV',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.lightBlue,
            primarySwatch: Colors.lightBlue,
            // primarySwatch: MaterialColor(0xFFFFFFFF, colorCodes),#
            // scaffoldBackgroundColor: const Color.fromARGB(255, 234, 238, 239),
            scaffoldBackgroundColor: const Color(0xffFFFFFF),
            inputDecorationTheme:
                const InputDecorationTheme(border: OutlineInputBorder()),
          ),
          initialRoute: Routes.loginScreen,
          routes: {
            Routes.loginScreen: (context) => const LoginScreen(),
            // Routes.loginScreen: (context) => const TestPage(),
            Routes.homeScreen: (context) => const HomeScreen(),
          },
          onUnknownRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            );
          },
        ),
      ),
    );
  }
}
