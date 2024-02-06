import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String src;
  final Function onClickClose;
  final bool rotate;
  final bool loop;

  VideoPlayerWidget({
    required this.src,
    required this.onClickClose,
    this.rotate = false,
    this.loop = false,
  });

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late bool _controlsActive = false;

  final _controlsHideAnimationDuration = const Duration(milliseconds: 500);
  Timer? _controlsHider;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.src)
      ..initialize().then((_) {
        setState(() {});
      });

    _controller.setLooping(widget.loop);
    _controller.play();

    _showVideoControls(autoHideDuration: Duration(seconds: 2));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget _buildVideoControls() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            },
            icon: Icon(
              _controller.value.isPlaying
                  ? Icons.pause_rounded
                  : Icons.play_arrow_rounded,
              color: Colors.grey.shade100,
            ),
          ),
          Expanded(
            child: VideoProgressIndicator(
              _controller,
              allowScrubbing: true,
              padding: EdgeInsets.only(right: 16, top: 8, bottom: 8),
              colors: VideoProgressColors(
                playedColor: Theme.of(context).colorScheme.tertiary,
                backgroundColor: Theme.of(context).colorScheme.onTertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return AnimatedSlide(
      duration: _controlsHideAnimationDuration,
      offset: _controlsActive ? Offset.zero : Offset(0, widget.rotate ? 2 : -2),
      child: FloatingActionButton(
        onPressed: () {
          widget.onClickClose();
        },
        backgroundColor: Colors.black.withOpacity(0.5),
        child: Icon(
          Icons.close,
        ),
      ),
    );
  }

  void _showVideoControls(
      {Duration autoHideDuration = const Duration(seconds: 5)}) {
    _controlsHider?.cancel();
    setState(() {
      _controlsActive = true;
    });
    _controlsHider = Timer(
      autoHideDuration,
      () => setState(() {
        _controlsActive = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _controller.value.isInitialized
          ? RotatedBox(
              quarterTurns: widget.rotate ? 1 : 0,
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.bottomCenter,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: _showVideoControls,
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedSlide(
                      duration: _controlsHideAnimationDuration,
                      offset: _controlsActive ? Offset.zero : Offset(0, 2),
                      child: _buildVideoControls(),
                    ),
                  ),
                ],
              ),
            )
          : null,
      floatingActionButtonLocation: widget.rotate
          ? FloatingActionButtonLocation.miniEndFloat
          : FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: _buildFloatingActionButton(),
    );
  }
}
