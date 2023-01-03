import 'package:flutter/material.dart';
import 'package:social_media_clean_archi/src/shared/presentation/widgets/custom_gradient_overlay.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class CustomVideoPlayer extends StatefulWidget {
  final String assetPath;
  final String? caption;
  final String? username;

  const CustomVideoPlayer({
    super.key,
    required this.assetPath,
    this.caption,
    this.username,
  });

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    if (widget.assetPath.startsWith('assets')) {
      _videoPlayerController = VideoPlayerController.asset(widget.assetPath);
    } else {
      _videoPlayerController =
          VideoPlayerController.file(File(widget.assetPath));
    }
    _videoPlayerController.initialize().then((_) => setState(() {}));
    _videoPlayerController.setLooping(true);
    _videoPlayerController.play();

    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_videoPlayerController.value.isPlaying) {
            _videoPlayerController.pause();
          } else {
            _videoPlayerController.play();
          }
        });
      },
      child: AspectRatio(
          aspectRatio: _videoPlayerController.value.aspectRatio,
          child: Stack(
            children: [
              VideoPlayer(_videoPlayerController),
              const CustomGradientOverlay(),
              (widget.caption == null || widget.username == null)
                  ? const SizedBox()
                  : _VideoCaption(
                      username: widget.username!, caption: widget.caption!),
            ],
          )),
    );
  }
}

class _VideoCaption extends StatelessWidget {
  const _VideoCaption({
    Key? key,
    required this.username,
    required this.caption,
  }) : super(key: key);

  final String username;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        height: 125,
        padding: const EdgeInsets.all(20.0),
        width: MediaQuery.of(context).size.width * 0.75,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(username, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 5),
            Text(caption, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
