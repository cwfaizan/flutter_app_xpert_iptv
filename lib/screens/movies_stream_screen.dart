import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:xpert_iptv/screens/player_screen.dart';
import 'package:xpert_iptv/utils/network_client.dart';

import '../providers/movies_stream_provider.dart';
import '../utils/helper.dart';

class MoviesStreamScreen extends StatefulWidget {
  final String categoryId;
  const MoviesStreamScreen({Key? key, required this.categoryId})
      : super(key: key);

  @override
  State<MoviesStreamScreen> createState() => _MoviesStreamScreenState();
}

class _MoviesStreamScreenState extends State<MoviesStreamScreen> {
  @override
  void initState() {
    final mSP = Provider.of<MoviesStreamProvider>(context, listen: false);
    mSP.moviesStreamList.clear();
    mSP.loadMoviesStreamList(widget.categoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mSP = Provider.of<MoviesStreamProvider>(context, listen: false);
    return Scaffold(
      body: Column(
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
              onChanged: (value) => mSP.search(value),
              decoration: const InputDecoration(hintText: 'Search here...'),
            ),
          ),
          Consumer<MoviesStreamProvider>(
            builder: (context, moviesStreamProvider, child) => Expanded(
              child: RPadding(
                padding: REdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 3
                        : 4,
                    childAspectRatio: 1,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 3,
                  ),
                  itemCount: moviesStreamProvider.moviesStreamList.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: GridTile(
                        child: InkWell(
                          child: moviesStreamProvider
                                      .moviesStreamList[index].streamIcon ==
                                  null
                              ? SvgPicture.asset('assets/images/icons/6.svg')
                              : FadeInImage.assetNetwork(
                                  image: moviesStreamProvider
                                      .moviesStreamList[index].streamIcon,
                                  placeholder: 'assets/images/logo_black.png',
                                  fit: BoxFit.fill,
                                ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PlayerScreen(
                                  url:
                                      '${Helper.baseUrl}/movie/${moviesStreamProvider.username}/${moviesStreamProvider.password}/${moviesStreamProvider.moviesStreamList[index].streamId}.${moviesStreamProvider.moviesStreamList[index].containerExtension}'),
                            ));
                          },
                        ),
                        footer: GridTileBar(
                          backgroundColor: Colors.black87,
                          title: Text(
                            moviesStreamProvider.moviesStreamList[index].name,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
