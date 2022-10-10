import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

// ignore: must_be_immutable
class PlayerScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final url;
  const PlayerScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  void initState() {
    super.initState();
    Wakelock.enable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: FutureBuilder(
          future: getPlayerController(),
          builder: (context, snapshot) => Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              snapshot.hasData
                  ? Chewie(
                      controller: snapshot.data as ChewieController,
                    )
                  : const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }

  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  Future<ChewieController> getPlayerController() async {
    videoPlayerController = VideoPlayerController.network(widget.url);
    await videoPlayerController?.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoPlay: true,
      looping: true,
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: () => debugPrint('My option works!'),
            iconData: Icons.chat,
            title: 'My localized title',
          ),
          OptionItem(
            onTap: () => debugPrint('Another option working!'),
            iconData: Icons.chat,
            title: 'Another localized title',
          ),
        ];
      },
      // aspectRatio: 16 / 9,
    );

    return chewieController!;
  }

  @override
  void dispose() {
    videoPlayerController!.dispose();
    chewieController!.dispose();
    Wakelock.disable();
    super.dispose();
  }
}
