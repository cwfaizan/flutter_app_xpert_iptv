import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:xpert_iptv/screens/series_stream_episode_screen.dart';

import '../providers/series_stream_provider.dart';

class SeriesStreamScreen extends StatefulWidget {
  final String categoryId;
  const SeriesStreamScreen({Key? key, required this.categoryId})
      : super(key: key);

  @override
  State<SeriesStreamScreen> createState() => _SeriesStreamScreenState();
}

class _SeriesStreamScreenState extends State<SeriesStreamScreen> {
  @override
  void initState() {
    final sSP = Provider.of<SeriesStreamProvider>(context, listen: false);
    sSP.seriesStreamList.clear();
    sSP.loadSeriesStreamList(widget.categoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sSP = Provider.of<SeriesStreamProvider>(context, listen: false);
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
              onChanged: (value) => sSP.search(value),
              decoration: const InputDecoration(hintText: 'Search here...'),
            ),
          ),
          Consumer<SeriesStreamProvider>(
            builder: (context, seriesStreamProvider, child) => Expanded(
              child: RPadding(
                padding: REdgeInsets.all(8.0),
                child: seriesStreamProvider.seriesStreamList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? 3
                              : 4,
                          childAspectRatio: 1,
                          crossAxisSpacing: 3,
                          mainAxisSpacing: 3,
                        ),
                        itemCount: seriesStreamProvider.seriesStreamList.length,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: GridTile(
                              child: InkWell(
                                child: Image.network(
                                  seriesStreamProvider
                                      .seriesStreamList[index].cover,
                                  fit: BoxFit.fill,
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        SeriesStreamEpisodeScreen(
                                            seriesStream: seriesStreamProvider
                                                .seriesStreamList[index]),
                                  ));
                                },
                              ),
                              footer: GridTileBar(
                                backgroundColor: Colors.black87,
                                title: Text(
                                  seriesStreamProvider
                                      .seriesStreamList[index].name,
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
