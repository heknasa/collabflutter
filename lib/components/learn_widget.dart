import 'dart:math';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collabflutter/components/learn_dialog.dart';
import 'package:flutter/material.dart';
import 'package:collabflutter/providers/theme_provider.dart';

class Learn extends HookWidget {
  const Learn({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final AnimationController _animationController = useAnimationController(duration: Duration(seconds: 1));
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
              ..setEntry(3, 2, 0.002)
              ..rotateY(pi * _animationController.value),
          child: GestureDetector(
            onTap: () { 
              if (_animationController.isCompleted) {
                _animationController.reverse();
              } else {
                _animationController.forward();
              }
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Padding(
                padding: EdgeInsets.all(width <= breakpoint ? 0.0 : 10.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(height * 0.01),
                  ),
                  elevation: height * 0.01,
                  child: _animationController.value <= 0.5
                  ? Stack(
                    children: [
                      ClipRRect(
                        child: ImageFiltered(
                          imageFilter: ImageFilter.blur(
                            sigmaX: 1,
                            sigmaY: 1,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(height * 0.01),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                  'https://source.unsplash.com/0MoF-Fe0w0A/',                                        
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(                                  
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Halo Mas Gor Gimana Kabarnya?',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width <= breakpoint ? subtitle1 * mobile : subtitle1,
                              fontWeight: semibold,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(height * 0.01),
                            color: Colors.black.withOpacity(0.2)
                          ),
                        ),                                  
                      ),                                
                    ],
                  )
                  : Transform(
                    transform: Matrix4.identity()..rotateY(pi),
                    alignment: Alignment.center,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Digital Marketing',
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: width <= breakpoint ? subtitle2 * mobile : subtitle2,
                                fontWeight: semibold,
                              )
                            )
                          ),
                          SizedBox(height: height * 0.01),
                          ElevatedButton(
                            onPressed: () {
                              showGeneralDialog(
                                context: context,
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  return LearnDialog(
                                    width: width,
                                    height: height,
                                  );
                                }
                              );
                            },
                            child: Text(
                              'REVEAL',
                              style: TextStyle(
                                fontSize: width <= breakpoint ? overline * mobile : button,
                                fontWeight: semibold,
                              )
                            )
                          ),
                        ],
                      )
                    ),
                  )
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}