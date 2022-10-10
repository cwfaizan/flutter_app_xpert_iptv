import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:xpert_iptv/providers/live_tv_stream_provider.dart';
import 'package:xpert_iptv/screens/player_screen.dart';
import 'package:xpert_iptv/utils/helper.dart';
import 'package:xpert_iptv/utils/network_client.dart';

class LiveTvStreamScreen extends StatefulWidget {
  final String categoryId;
  const LiveTvStreamScreen({Key? key, required this.categoryId})
      : super(key: key);

  @override
  State<LiveTvStreamScreen> createState() => _LiveTvStreamScreenState();
}

class _LiveTvStreamScreenState extends State<LiveTvStreamScreen> {
  @override
  void initState() {
    final lTvSP = Provider.of<LiveTvStreamProvider>(context, listen: false);
    lTvSP.liveTvStreamList.clear();
    lTvSP.loadLiveTvStreamList(widget.categoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lTvSP = Provider.of<LiveTvStreamProvider>(context, listen: false);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
              onChanged: (value) => lTvSP.search(value),
              decoration: const InputDecoration(hintText: 'Search here...'),
            ),
          ),
          Consumer<LiveTvStreamProvider>(
            builder: (context, liveTvStreamProvider, child) =>
                liveTvStreamProvider.liveTvStreamList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: RPadding(
                          padding: REdgeInsets.all(8.0),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? 2
                                      : 4,
                              childAspectRatio: 1,
                              crossAxisSpacing: 3,
                              mainAxisSpacing: 3,
                            ),
                            itemCount:
                                liveTvStreamProvider.liveTvStreamList.length,
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: GridTile(
                                  child: InkWell(
                                    child: Image.network(
                                      liveTvStreamProvider
                                          .liveTvStreamList[index].streamIcon,
                                      fit: BoxFit.contain,
                                    ),
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => PlayerScreen(
                                            url:
                                                '${Helper.baseUrl}/${liveTvStreamProvider.username}/${liveTvStreamProvider.password}/${liveTvStreamProvider.liveTvStreamList[index].streamId}'),
                                      ));
                                    },
                                  ),
                                  footer: GridTileBar(
                                    backgroundColor: Colors.black87,
                                    title: Text(
                                      liveTvStreamProvider
                                          .liveTvStreamList[index].name,
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
