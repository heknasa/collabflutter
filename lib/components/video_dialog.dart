import 'dart:async';
import 'dart:ui';

import 'package:collabflutter/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoDialog extends StatefulWidget {
  final double width;
  final double height;

  const VideoDialog({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);  

  @override
  State<VideoDialog> createState() => _VideoDialogState();
}

class _VideoDialogState extends State<VideoDialog> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {    
    _videoPlayerController = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
    super.initState();    
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();    
  }

  @override
  Widget build(BuildContext context) {    
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              color: Colors.black,
              width: widget.width,
              height: widget.height,
              child: Stack(
                children: [
                  VideoPlayer(_videoPlayerController),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: HookBuilder(
                      builder: (context) {
                        ValueNotifier<double> controlsOpacity = useState(1.0);
                        final _animationController = useAnimationController(duration: Duration(milliseconds: 100));
                        final _valueNotifier = useValueListenable(_videoPlayerController);
                        if (_valueNotifier.position == _valueNotifier.duration) {
                          controlsOpacity.value = 1.0;
                          _animationController.reverse();
                        }                        
                        return MouseRegion(
                          onEnter: (s) {
                            controlsOpacity.value = 1.0;
                          },
                          onExit: (s) {
                            controlsOpacity.value = 0.0;
                          },
                          child: AnimatedOpacity(
                            opacity: Theme.of(context).platform != TargetPlatform.android
                                || Theme.of(context).platform != TargetPlatform.iOS
                                ? controlsOpacity.value
                                : 1.0,
                            duration: Duration(milliseconds: 100),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                                child: Container(
                                  margin: EdgeInsets.only(bottom: widget.height * 0.05),                      
                                  width: widget.width * 0.5,
                                  height: widget.height * 0.15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.black.withOpacity(0.8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.8),
                                        offset: Offset(0, 5),
                                        blurRadius: 5
                                      )
                                    ]
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      VideoProgressIndicator(
                                        _videoPlayerController,
                                        allowScrubbing: true,
                                        padding: EdgeInsets.only(top: 0),
                                        colors: VideoProgressColors(
                                          playedColor: Colors.blueAccent,
                                          bufferedColor: Colors.blueAccent.withOpacity(0.25),
                                          backgroundColor: Colors.white.withOpacity(0.5)
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,                                  
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (_valueNotifier.position - Duration(seconds: 1) > (Duration())) {
                                                _videoPlayerController.seekTo(_valueNotifier.position - Duration(seconds: 1));
                                              } else {
                                                _videoPlayerController.seekTo(Duration());
                                              }
                                            },
                                            child: MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: Icon(
                                                Icons.skip_previous,
                                                size: 40.0,
                                                color: Colors.white.withOpacity(0.8),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {                                        
                                              if (!_videoPlayerController.value.isPlaying) {
                                                _animationController.forward();
                                                _videoPlayerController.play();
                                              } else {
                                                _animationController.reverse();
                                                _videoPlayerController.pause();
                                              }
                                            },
                                            child: MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: Container(                                      
                                                width: 50.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.white.withOpacity(0.8),
                                                  shape: BoxShape.circle
                                                ),
                                                child: Center(
                                                  child: _valueNotifier.position != _valueNotifier.duration
                                                  ? AnimatedIcon(
                                                    progress: _animationController,
                                                    icon: AnimatedIcons.play_pause,
                                                    size: 40.0,
                                                    color: Colors.black.withOpacity(0.8))
                                                  : Icon(
                                                    Icons.replay,
                                                    size: 40.0,
                                                    color: Colors.black.withOpacity(0.8)
                                                  )
                                                  ,
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (_valueNotifier.position + Duration(seconds: 1) < _valueNotifier.duration) {
                                                _videoPlayerController.seekTo(_valueNotifier.position + Duration(seconds: 1));
                                              } else {
                                                _videoPlayerController.seekTo(_valueNotifier.duration);
                                              }
                                            },
                                            child: MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: Icon(
                                                Icons.skip_next,
                                                size: 40.0,
                                                color: Colors.white.withOpacity(0.8),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              [_valueNotifier.position.inMinutes,
                                                _valueNotifier.position.inSeconds.remainder(60)]
                                                  .map((digit) => digit.toString().padLeft(2, '0'))
                                                  .join(':'),
                                              style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontWeight: semibold
                                              ),
                                            ),
                                            Text(
                                              [(_valueNotifier.duration - _valueNotifier.position).inMinutes,
                                                (_valueNotifier.duration - _valueNotifier.position).inSeconds.remainder(60)]
                                                  .map((digit) => digit.toString().padLeft(2, '0'))
                                                  .join(':'),
                                              style: TextStyle(
                                                color: Colors.white.withOpacity(0.4),
                                                fontWeight: semibold
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),                        
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0.0),
                          child: Icon(
                            Icons.fullscreen_exit,
                            size: 40.0,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );            
          }
          return Center(
            child: CircularProgressIndicator(color: Colors.white)
          );
        }
      ),
    );
  }  
}